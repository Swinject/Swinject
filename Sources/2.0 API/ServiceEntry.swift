//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

/// The `ServiceEntry<Service>` class represents an entry of a registered service type.
/// As a returned instance from a `register` method of a `Container`, some configurations can be added.
public struct ServiceEntry<Service> {
    private let builder: (Resolver, Any, Any) throws -> Service
    private var key: AnyBindingKey
    private var scope: AnyScope?
    private var initCompleted = [(Resolver, Any) throws -> Void]()

    var objectScope: ObjectScope? { return nil }

    init<Context, Argument>(
        contextType: Context.Type,
        argumentType: Argument.Type,
        name: String?,
        builder: @escaping (Resolver, Any, Any) throws -> Service,
        scope: AnyScope?
    ) {
        self.builder = builder
        if let name = name {
            self.key = BindingKey<Tagged<Service, String>, Context, Argument>(
                descriptor: tagged(Service.self, with: name)
            )
        } else {
            self.key = BindingKey<Tagged<Service, NoTag>, Context, Argument>(descriptor: plain(Service.self))
        }
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
        return self
    }
}

extension ServiceEntry: Binding {
    public func matches(_ key: AnyBindingKey) -> Bool {
        self.key.matches(key)
    }

    public func instance(arg: Any, context: Any, resolver: Resolver) throws -> Any {
        if let scope = scope {
            return try scope.registry(for: context).instance(
                for: ScopeRegistryKey(descriptor: key.descriptor, argument: arg),
                builder: { try builder(resolver, context, arg) },
                finalizer: { instance in try initCompleted.forEach { try $0(resolver, instance) } }
            )
        } else {
            return try builder(resolver, context, arg)
        }
    }
}
