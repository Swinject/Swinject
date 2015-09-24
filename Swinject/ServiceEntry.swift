//
//  ServiceEntry.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/24/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Foundation

/// The `ServiceEntryBase` class represents an entry of a registered service type.
/// It is free from generics to store in a strongly typed collection.
/// `ServiceEntry<Service>` should be actually used.
public class ServiceEntryBase {
    internal let factory: Any // Must be a function type.
    internal var scope = ObjectScope.Graph
    internal var instance: Any?
    internal var initCompleted: Any? // Must be a function type.
    
    internal init(factory: Any) {
        self.factory = factory
    }
    
    /// Specifies the object scope to resolve the service.
    ///
    /// - Parameter scope: The `ObjectScope` value.
    ///
    /// - Returns: `self` to add another configuration fluently.
    public func inObjectScope(scope: ObjectScope) -> Self {
        self.scope = scope
        return self
    }
}

/// The `ServiceEntry<Service>` class represents an entry of a registered service type.
/// As a returned instance from a `register` method of a `Container`, some configurations can be added.
public final class ServiceEntry<Service>: ServiceEntryBase {
    private let serviceType: Service.Type
    
    internal init(serviceType: Service.Type, factory: Any) {
        self.serviceType = serviceType
        super.init(factory: factory)
    }

    // Initializer for Container.registerForStoryboard.
    internal convenience init(serviceType: Service.Type) {
        let emptyFactory: () -> () = { }
        self.init(serviceType: serviceType, factory: emptyFactory)
    }

    internal func copyExceptInstance() -> ServiceEntry<Service> {
        let copy = ServiceEntry(serviceType: serviceType, factory: factory)
        copy.scope = scope
        copy.initCompleted = initCompleted
        return copy
    }
    
    /// Adds the callback to setup the instance after its `init` completes.
    /// *Property or method injections* can be performed in the callback.
    /// To resolve *circular dependencies*, `initCompleted` must be used.
    ///
    /// - Parameter completed: The closure to be called after the instantiation of the registered service.
    ///
    /// - Returns: `self` to add another configuration fluently.
    public func initCompleted(completed: (Resolvable, Service) -> ()) -> Self {
        initCompleted = completed
        return self
    }
}
