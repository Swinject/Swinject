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
    
    public func register<Service>(serviceType: Service.Type, factory: Container -> Service) {
        let key = ServiceKey(factoryType: factory.dynamicType)
        factories[key] = factory as Any
    }

    public func register<Service, Arg>(serviceType: Service.Type, factory: (Container, Arg) -> Service) {
        let key = ServiceKey(factoryType: factory.dynamicType)
        factories[key] = factory as Any
    }
    
    public func register<Service, Arg1, Arg2>(serviceType: Service.Type, factory: (Container, Arg1, Arg2) -> Service) {
        let key = ServiceKey(factoryType: factory.dynamicType)
        factories[key] = factory as Any
    }

    public func resolve<Service>(serviceType: Service.Type) -> Service? {
        typealias FactoryType = Container -> Service
        let key = ServiceKey(factoryType: FactoryType.self)
        if let factory = factories[key] as? Container -> Service {
            return factory(self)
        }
        return nil
    }
    
    public func resolve<Service, Arg>(serviceType: Service.Type, arg1: Arg) -> Service? {
        typealias FactoryType = (Container, Arg) -> Service
        let key = ServiceKey(factoryType: FactoryType.self)
        if let factory = factories[key] as? (Container, Arg) -> Service {
            return factory(self, arg1)
        }
        return nil
    }
    
    public func resolve<Service, Arg1, Arg2>(serviceType: Service.Type, arg1: Arg1, arg2: Arg2) -> Service? {
        typealias FactoryType = (Container, Arg1, Arg2) -> Service
        let key = ServiceKey(factoryType: FactoryType.self)
        if let factory = factories[key] as? (Container, Arg1, Arg2) -> Service {
            return factory(self, arg1, arg2)
        }
        return nil
    }
}
