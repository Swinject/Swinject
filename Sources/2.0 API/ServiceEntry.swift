//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

/// The `ServiceEntry<Service>` class represents an entry of a registered service type.
/// As a returned instance from a `register` method of a `Container`, some configurations can be added.
public class ServiceEntry<Service> {
    weak var container: Container?
    let builder: (Resolver, Any, Any) -> Service
    let argumentType: Any.Type
    let name: String?
    var scope: AnyScope?
    var makeRef: ReferenceMaker<Any>
    var finalizers = [(Resolver, Service) -> Void]()
    var forwardedDescriptors = [TypeDescriptor]()

    init<Argument>(
        container: Container,
        name: String?,
        scope: AnyScope?,
        makeRef: @escaping ReferenceMaker<Any>,
        builder: @escaping (Resolver, Any, Argument) -> Service
    ) {
        self.container = container
        self.name = name
        self.scope = scope
        self.makeRef = makeRef
        self.builder = { builder($0, $1, $2 as! Argument) }
        argumentType = Argument.self
    }

    /// Specifies a custom scope & reference maker to use for the service.
    ///
    /// - Parameter scope: A custom scope to be used with entry.
    /// - Parameter makeRef: A reference maker, `strongRef` by default
    ///
    /// - Returns: `self` to add another configuration fluently.
    @discardableResult
    public func inObjectScope(
        _ scope: AnyScope?,
        makeRef: @escaping ReferenceMaker<Any> = strongRef
    ) -> Self {
        self.scope = scope
        self.makeRef = makeRef
        return self
    }

    /// Specifies the object scope to use for the service.
    ///
    /// - Parameter scope: The `ObjectScope` value.
    ///
    /// - Returns: `self` to add another configuration fluently.
    @discardableResult
    public func inObjectScope(_ objectScope: ObjectScope) -> Self {
        return inObjectScope(objectScope.scope, makeRef: objectScope.makeRef)
    }

    /// Adds the callback to setup the instance after its `init` completes.
    /// *Property or method injections* can be performed in the callback.
    /// To resolve *circular dependencies*, `initCompleted` must be used.
    ///
    /// - Parameter completed: The closure to be called after the instantiation of the registered service.
    ///
    /// - Returns: `self` to add another configuration fluently.
    @discardableResult
    public func initCompleted(_ completed: @escaping (Resolver, Service) -> Void) -> Self {
        finalizers.append { completed($0, $1) }
        return self
    }
}

extension ServiceEntry: Binding {
    public var properties: BindingProperties {
        return BindingProperties(
            descriptor: key.descriptor,
            overrides: false
        )
    }

    public func instance(arg: Any, context: Any, resolver: Resolver) throws -> Any {
        if let scope = scope {
            return getRegistry(scope: scope, context: context).instance(
                for: ScopeRegistryKey(descriptor: key.descriptor, argument: arg),
                builder: { makeRef(builder(resolver, context, arg)) },
                finalizer: { instance in finalizers.forEach { $0(resolver, instance as! Service) } }
            )
        } else {
            return builder(resolver, context, arg)
        }
    }

    private func getRegistry(scope: AnyScope, context: Any) -> ScopeRegistry {
        if scope is ContainerScope, let container = container {
            return scope.registry(for: container)
        }
        if scope is WeakScope, let container = container, let graph = context as? Graph {
            return scope.registry(for: (container, graph))
        }
        return scope.registry(for: context)
    }

    public var key: BindingKey {
        return BindingKey(
            descriptor: tagged(Service.self, with: name),
            contextType: scope?.contextType ?? Any.self,
            argumentType: argumentType
        )
    }
}

extension ServiceEntry: CustomStringConvertible {
    public var description: String {
        return [
            "Service: \(Service.self)",
            name.map { "Name: \"\($0)\"" },
            "Factory: (\(factoryInputs)) -> \(Service.self)",
            "ObjectScope: \(scopeDescription)",
            finalizers.isEmpty ? nil : "InitCompleted: Specified \(finalizers.count) closures",
        ].compactMap { $0 }.joined(separator: ", ")
    }

    private var factoryInputs: String {
        return ["Resolver", argumentTypes].compactMap { $0 }.joined(separator: ", ")
    }

    private var argumentTypes: String? {
        var result = "\(argumentType)"
        if result.hasPrefix("("), result.hasSuffix(")") {
            result = String(result.dropFirst().dropLast())
        }
        return result.isEmpty ? nil : result
    }

    private var scopeDescription: String {
        guard let scope = scope else { return "transient" }
        return String(describing: scope)
    }
}
