//
//  Container.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/23/15.
//  Copyright © 2015 DevSwinject. All rights reserved.
//

import Foundation

public final class Container {
    private var factories = [Any]()
    
    // The first argument is for a workaround to the problem that cannot explicitly specialize a generic function in Swift.
    // http://stackoverflow.com/questions/28726937/how-do-i-call-a-generic-swift-function-when-none-of-the-arguments-provides-the-g
    public func register<Service>(_: Service.Type, factory: Container -> Service) {
        factories += [factory as Any]
    }
    
    public func resolve<Service>(_: Service.Type) -> Service? {
        for factory in factories {
            if let factory = factory as? Container -> Service {
                return factory(self)
            }
        }
        return nil
    }
}
