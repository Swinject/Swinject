//
//  Container.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/23/15.
//  Copyright © 2015 DevSwinject. All rights reserved.
//

import Foundation

public final class Container {
    private var services = [ServiceKey: ServiceEntry]()
    private let parent: Container?
    
    public init() {
        self.parent = nil
    }
    
    public init(parent: Container) {
        self.parent = parent
    }
    
    public func register<Service>(_: Service.Type, name: String? = nil, factory: Container -> Service) -> RegistrationType {
        return registerImpl(factory, name: name)
    }

    public func register<Service, Arg1>(_: Service.Type, name: String? = nil, factory: (Container, Arg1) -> Service) -> RegistrationType {
        return registerImpl(factory, name: name)
    }
    
    public func register<Service, Arg1, Arg2>(_: Service.Type, name: String? = nil, factory: (Container, Arg1, Arg2) -> Service) -> RegistrationType {
        return registerImpl(factory, name: name)
    }

    public func resolve<Service>(_: Service.Type, name: String? = nil) -> Service? {
        typealias FactoryType = Container -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self) }
    }
    
    public func resolve<Service, Arg1>(_: Service.Type, arg1: Arg1, name: String? = nil) -> Service? {
        typealias FactoryType = (Container, Arg1) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arg1) }
    }
    
    public func resolve<Service, Arg1, Arg2>(_: Service.Type, arg1: Arg1, arg2: Arg2, name: String? = nil) -> Service? {
        typealias FactoryType = (Container, Arg1, Arg2) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arg1, arg2) }
    }
    
    private func registerImpl<Factory>(factory: Factory, name: String?) -> RegistrationType {
        let key = ServiceKey(factoryType: factory.dynamicType, name: name)
        let entry = ServiceEntry(factory: factory)
        services[key] = entry
        return entry
    }
    
    private func resolveImpl<Service, Factory>(name: String?, invoke: Factory -> Service) -> Service? {
        var resolvedInstance: Service?
        let key = ServiceKey(factoryType: Factory.self, name: name)
        if let (entry, fromParent) = getEntry(key) {
            switch (entry.scope) {
            case .None:
                resolvedInstance = invoke(entry.factory as! Factory)
            case .Container:
                let ownEntry: ServiceEntry
                if fromParent {
                    ownEntry = ServiceEntry(factory: entry.factory)
                    ownEntry.scope = entry.scope
                    services[key] = ownEntry
                }
                else {
                    ownEntry = entry
                }
                
                if ownEntry.instance == nil {
                    ownEntry.instance = invoke(ownEntry.factory as! Factory) as? AnyObject
                }
                resolvedInstance = ownEntry.instance as? Service
            case .Hierarchy:
                if entry.instance == nil {
                    entry.instance = invoke(entry.factory as! Factory) as? AnyObject
                }
                resolvedInstance = entry.instance as? Service
            }
        }
        return resolvedInstance
    }
    
    private func getEntry(key: ServiceKey) -> (ServiceEntry, Bool)? {
        var fromParent = false
        var entry = services[key]
        if entry == nil, let parent = self.parent {
            if let (parentEntry, _) = parent.getEntry(key) {
                entry = parentEntry
                fromParent = true
            }
        }
        return entry.map { ($0, fromParent) }
    }
}
