//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Foundation

// A generic-type-free protocol to be the type of values in a strongly-typed collection.
internal protocol ServiceEntryProtocol: AnyObject {
    func describeWithKey(_ serviceKey: ServiceKey) -> String
    var objectScope: ObjectScopeProtocol { get }
    var storage: InstanceStorage { get }
    var factory: FunctionType { get }
    var initCompleted: (FunctionType)? { get }
    var serviceType: Any.Type { get }
}

/// The `ServiceEntry<Service>` class represents an entry of a registered service type.
/// As a returned instance from a `register` method of a `Container`, some configurations can be added.
public final class ServiceEntry<Service>: ServiceEntryProtocol {
    fileprivate var initCompletedActions: [(Resolver, Service) -> Void] = []
    internal let serviceType: Any.Type
    internal let argumentsType: Any.Type

    internal let factory: FunctionType
    internal weak var container: Container?

    internal var objectScope: ObjectScopeProtocol = ObjectScope.graph
    internal lazy var storage: InstanceStorage = { [unowned self] in
        self.objectScope.makeStorage()
    }()

    internal var initCompleted: FunctionType? {
        guard !initCompletedActions.isEmpty else { return nil }

        return { [weak self] (resolver: Resolver, service: Any) -> Void in
            guard let strongSelf = self else { return }
            strongSelf.initCompletedActions.forEach { $0(resolver, service as! Service) }
        }
    }

    internal init(serviceType: Service.Type, argumentsType: Any.Type, factory: FunctionType) {
        self.serviceType = serviceType
        self.argumentsType = argumentsType
        self.factory = factory
    }

    internal convenience init(
        serviceType: Service.Type,
        argumentsType: Any.Type,
        factory: FunctionType,
        objectScope: ObjectScope
    ) {
        self.init(serviceType: serviceType, argumentsType: argumentsType, factory: factory)
        self.objectScope = objectScope
    }

    /// Specifies the object scope to resolve the service.
    ///
    /// - Parameter scope: The `ObjectScopeProtocol` value.
    ///
    /// - Returns: `self` to add another configuration fluently.
    @discardableResult
    public func inObjectScope(_ objectScope: ObjectScopeProtocol) -> Self {
        self.objectScope = objectScope
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
        return inObjectScope(objectScope as ObjectScopeProtocol)
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
        initCompletedActions.append(completed)
        return self
    }

    internal func describeWithKey(_ serviceKey: ServiceKey) -> String {
        return description(
            serviceType: serviceType,
            serviceKey: serviceKey,
            objectScope: objectScope,
            initCompleted: initCompletedActions
        )
    }
}
