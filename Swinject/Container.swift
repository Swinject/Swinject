//
//  Container.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/23/15.
//  Copyright © 2015 DevSwinject. All rights reserved.
//

import Foundation

public final class Container {
    private var factories = [String: Any]()
    
    public func register<Service>(serviceType: Service.Type, factory: Container -> Service) {
        factories[String(serviceType)] = factory as Any
    }
    
    public func resolve<Service>(serviceType: Service.Type) -> Service? {
        if let factory = factories[String(serviceType)] as? Container -> Service {
            return factory(self)
        }
        return nil
    }
}
