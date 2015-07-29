//
//  ServiceEntry.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/24/15.
//  Copyright © 2015 DevSwinject. All rights reserved.
//

import Foundation

public class ServiceEntryBase {
    internal let factory: Any // Must be a function type.
    internal var scope = ObjectScope.Graph
    internal var instance: AnyObject?
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
    
    internal func copyExceptInstance() -> ServiceEntry<Service> {
        let copy = ServiceEntry(serviceType: serviceType, factory: factory)
        copy.scope = scope
        copy.initCompleted = initCompleted
        return copy
    }
    
    public func initCompleted(completed: (Container, Service) -> ()) -> Self {
        initCompleted = completed
        return self
    }
}
