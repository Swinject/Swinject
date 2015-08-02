//
//  ServiceEntry.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/24/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Foundation

public class ServiceEntryBase {
    internal let factory: Any // Must be a function type.
    internal var scope = ObjectScope.Graph
    internal var instance: Any?
    internal var initCompleted: Any? // Must be a function type.
    
    internal init(factory: Any) {
        self.factory = factory
    }
    
    public func inObjectScope(scope: ObjectScope) -> Self {
        self.scope = scope
        return self
    }
}

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
    
    public func initCompleted(completed: (Resolvable, Service) -> ()) -> Self {
        initCompleted = completed
        return self
    }
}
