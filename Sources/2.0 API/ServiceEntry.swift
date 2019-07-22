//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

/// The `ServiceEntry<Service>` class represents an entry of a registered service type.
/// As a returned instance from a `register` method of a `Container`, some configurations can be added.
public class ServiceEntry<Service> {
    private let builder: (Resolver, Any, Any) -> Service
    private var key: AnyBindingKey
    private var scope: AnyScope?
    private var finalizers = [(Resolver, Service) -> Void]()

    var objectScope: ObjectScope? { return nil }

    init<Argument>(
        name: String?,
        scope: AnyScope?,
        builder: @escaping (Resolver, Any, Argument) -> Service
    ) {
        self.builder = { builder($0, $1, $2 as! Argument) }
        self.key = BindingKey(
            descriptor: {
                if let name = name {
                    return tagged(Service.self, with: name)
                } else {
                    return plain(Service.self)
                }
            }(),
            contextType: Any.self,
            argumentType: Argument.self
        )
        self.scope = scope
    }

    /// Specifies the object scope to resolve the service.
    ///
    /// - Parameter scope: The `ObjectScopeProtocol` value.
    ///
    /// - Returns: `self` to add another configuration fluently.
    @discardableResult
    public func inObjectScope<ObjectScope>(_ scope: ObjectScope) -> Self where ObjectScope: Scope {
        return self
    }

    /// Specifies the object scope to resolve the service.
    /// Performs the same functionality as `inObjectScope(_: ObjectScopeProtocol) -> Self`,
    /// but provides more convenient usage syntax.
    ///
    /// - Parameter scope: The `ObjectScope` value.
    ///
    /// - Returns: `self` to add another configuration fluently.
    @discardableResult
    public func inObjectScope(_ objectScope: ObjectScope) -> Self {
        return self
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
    public func matches(_ key: AnyBindingKey) -> Bool {
        self.key.matches(key)
    }

    public func instance(arg: Any, context: Any, resolver: Resolver) throws -> Any {
        if let scope = scope {
            return scope.registry(for: context).instance(
                for: ScopeRegistryKey(descriptor: key.descriptor, argument: arg),
                builder: { builder(resolver, context, arg) },
                finalizer: { instance in finalizers.forEach { $0(resolver, instance as! Service) } }
            )
        } else {
            return builder(resolver, context, arg)
        }
    }
}
