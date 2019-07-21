//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

/// The `ServiceEntry<Service>` class represents an entry of a registered service type.
/// As a returned instance from a `register` method of a `Container`, some configurations can be added.
public struct ServiceEntry<Service> {
    let objectScope: ObjectScope

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
