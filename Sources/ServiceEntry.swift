//
//  ServiceEntry.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/24/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Foundation

// A generic-type-free protocol to be the type of values in a strongly-typed collection.
internal typealias ServiceEntryType = Any

/// The `ServiceEntry<Service>` class represents an entry of a registered service type.
/// As a returned instance from a `register` method of a `Container`, some configurations can be added.
public final class ServiceEntry<Service>: ServiceEntryType {
    private let serviceType: Service.Type
    internal let factory: FunctionType

    internal var objectScope = ObjectScope.Graph
    internal var initCompleted: FunctionType?
    internal var instance: Any?

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
    /// - Parameter scope: The `ObjectScope` value.
    ///
    /// - Returns: `self` to add another configuration fluently.
    public func inObjectScope(objectScope: ObjectScope) -> Self {
        self.objectScope = objectScope
        return self
    }

    /// Adds the callback to setup the instance after its `init` completes.
    /// *Property or method injections* can be performed in the callback.
    /// To resolve *circular dependencies*, `initCompleted` must be used.
    ///
    /// - Parameter completed: The closure to be called after the instantiation of the registered service.
    ///
    /// - Returns: `self` to add another configuration fluently.
    public func initCompleted(completed: (ResolverType, Service) -> ()) -> Self {
        initCompleted = completed
        return self
    }
}
