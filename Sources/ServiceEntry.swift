//
//  ServiceEntry.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/24/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Foundation

// A generic-type-free protocol to be the type of values in a strongly-typed collection.
internal protocol ServiceEntryProtocol: Any {
    func describeWithKey(_ serviceKey: ServiceKey) -> String
    var objectScope: ObjectScopeProtocol { get }
    var storage: InstanceStorage { get }
}

/// The `ServiceEntry<Service>` class represents an entry of a registered service type.
/// As a returned instance from a `register` method of a `Container`, some configurations can be added.
public final class ServiceEntry<Service> {
    fileprivate let serviceType: Service.Type
    internal let factory: FunctionType

    internal var objectScope: ObjectScopeProtocol = ObjectScope.graph
    internal lazy var storage: InstanceStorage = { [unowned self] in
        self.objectScope.makeStorage()
    }()
    internal var initCompleted: FunctionType?

    internal init(serviceType: Service.Type, factory: FunctionType) {
        self.serviceType = serviceType
        self.factory = factory
    }

    internal func copyExceptInstance() -> ServiceEntry<Service> {
        let copy = ServiceEntry(serviceType: serviceType, factory: factory)
        copy.objectScope = objectScope
        copy.initCompleted = initCompleted
        return copy
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
        initCompleted = completed
        return self
    }
}

extension ServiceEntry: ServiceEntryProtocol {
    internal func describeWithKey(_ serviceKey: ServiceKey) -> String {
        return description(
            serviceType: serviceType,
            serviceKey: serviceKey,
            objectScope: objectScope,
            initCompleted: initCompleted
        )
    }
}
