//
//  Container.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/23/15.
//  Copyright © 2015 DevSwinject. All rights reserved.
//

import Foundation

public final class Container {
    private var services = [ServiceKey: ServiceEntryBase]()
    private let parent: Container?
    
    public init() {
        self.parent = nil
    }
    
    public init(parent: Container) {
        self.parent = parent
    }
    
    public func register<Service>(serviceType: Service.Type, name: String? = nil, factory: Container -> Service) -> ServiceEntry<Service> {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    public func register<Service, Arg1>(serviceType: Service.Type, name: String? = nil, factory: (Container, Arg1) -> Service) -> ServiceEntry<Service> {
        return registerImpl(serviceType, factory: factory, name: name)
    }
    
    public func register<Service, Arg1, Arg2>(serviceType: Service.Type, name: String? = nil, factory: (Container, Arg1, Arg2) -> Service) -> ServiceEntry<Service> {
        return registerImpl(serviceType, factory: factory, name: name)
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
    
    private func registerImpl<Service, Factory>(serviceType: Service.Type, factory: Factory, name: String?) -> ServiceEntry<Service> {
        let key = ServiceKey(factoryType: factory.dynamicType, name: name)
        let entry = ServiceEntry(serviceType: serviceType, factory: factory)
        services[key] = entry
        return entry
    }
    
    private func resolveImpl<Service, Factory>(name: String?, invoker: Factory -> Service) -> Service? {
        var resolvedInstance: Service?
        let key = ServiceKey(factoryType: Factory.self, name: name)
        if let (entry, fromParent) = getEntry(key) as (ServiceEntry<Service>, Bool)? {
            switch (entry.scope) {
            case .None:
                resolvedInstance = resolveEntry(entry, invoker: invoker)
            case .Container:
                let ownEntry: ServiceEntry<Service>
                if fromParent {
                    ownEntry = entry.copyExceptInstance()
                    services[key] = ownEntry
                }
                else {
                    ownEntry = entry
                }
                
                if ownEntry.instance == nil {
                    ownEntry.instance = resolveEntry(entry, invoker: invoker) as? AnyObject
                }
                resolvedInstance = ownEntry.instance as? Service
            case .Hierarchy:
                if entry.instance == nil {
                    entry.instance = resolveEntry(entry, invoker: invoker) as? AnyObject
                }
                resolvedInstance = entry.instance as? Service
            }
        }
        return resolvedInstance
    }
    
    private func getEntry<Service>(key: ServiceKey) -> (ServiceEntry<Service>, Bool)? {
        var fromParent = false
        var entry = services[key] as? ServiceEntry<Service>
        if entry == nil, let parent = self.parent {
            if let (parentEntry, _) = parent.getEntry(key) as (ServiceEntry<Service>, Bool)? {
                entry = parentEntry
                fromParent = true
            }
        }
        return entry.map { ($0, fromParent) }
    }
    
    private func resolveEntry<Service, Factory>(entry: ServiceEntry<Service>, invoker: Factory -> Service) -> Service {
        let resolvedInstance = invoker(entry.factory as! Factory)
        if let completed = entry.initCompleted as? (Container, Service) -> () {
            completed(self, resolvedInstance)
        }
        return resolvedInstance
    }
}
