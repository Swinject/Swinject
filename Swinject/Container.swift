//
//  Container.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/23/15.
//  Copyright © 2015 DevSwinject. All rights reserved.
//

import Foundation

public final class Container {
    private var factories = [ServiceKey: Any]()
    
    public func register<Service>(serviceType: Service.Type, name: String? = nil, factory: Container -> Service) {
        let key = ServiceKey(factoryType: factory.dynamicType, name: name)
        factories[key] = factory as Any
    }

    public func register<Service, Arg>(serviceType: Service.Type, name: String? = nil, factory: (Container, Arg) -> Service) {
        let key = ServiceKey(factoryType: factory.dynamicType, name: name)
        factories[key] = factory as Any
    }
    
    public func register<Service, Arg1, Arg2>(serviceType: Service.Type, name: String? = nil, factory: (Container, Arg1, Arg2) -> Service) {
        let key = ServiceKey(factoryType: factory.dynamicType, name: name)
        factories[key] = factory as Any
    }

    public func resolve<Service>(serviceType: Service.Type, name: String? = nil) -> Service? {
        typealias FactoryType = Container -> Service
        let key = ServiceKey(factoryType: FactoryType.self, name: name)
        if let factory = factories[key] as? FactoryType {
            return factory(self)
        }
        return nil
    }
    
    public func resolve<Service, Arg>(serviceType: Service.Type, arg1: Arg, name: String? = nil) -> Service? {
        typealias FactoryType = (Container, Arg) -> Service
        let key = ServiceKey(factoryType: FactoryType.self, name: name)
        if let factory = factories[key] as? FactoryType {
            return factory(self, arg1)
        }
        return nil
    }
    
    public func resolve<Service, Arg1, Arg2>(serviceType: Service.Type, arg1: Arg1, arg2: Arg2, name: String? = nil) -> Service? {
        typealias FactoryType = (Container, Arg1, Arg2) -> Service
        let key = ServiceKey(factoryType: FactoryType.self, name: name)
        if let factory = factories[key] as? FactoryType {
            return factory(self, arg1, arg2)
        }
        return nil
    }
}
