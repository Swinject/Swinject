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
    private var resolutionPool = ResolutionPool()
    
    public init() {
        self.parent = nil
    }
    
    public init(parent: Container) {
        self.parent = parent
    }
    
    public func register<Service>(serviceType: Service.Type, name: String? = nil, factory: Resolvable -> Service) -> ServiceEntry<Service> {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    public func register<Service, Arg1>(serviceType: Service.Type, name: String? = nil, factory: (Resolvable, Arg1) -> Service) -> ServiceEntry<Service> {
        return registerImpl(serviceType, factory: factory, name: name)
    }
    
    public func register<Service, Arg1, Arg2>(serviceType: Service.Type, name: String? = nil, factory: (Resolvable, Arg1, Arg2) -> Service) -> ServiceEntry<Service> {
        return registerImpl(serviceType, factory: factory, name: name)
    }
    
    private func registerImpl<Service, Factory>(serviceType: Service.Type, factory: Factory, name: String?) -> ServiceEntry<Service> {
        let key = ServiceKey(factoryType: factory.dynamicType, name: name)
        let entry = ServiceEntry(serviceType: serviceType, factory: factory)
        services[key] = entry
        return entry
    }
}

extension Container: Resolvable {
    public func resolve<Service>(serviceType: Service.Type) -> Service? {
        return resolve(serviceType, name: nil)
    }
    
    public func resolve<Service, Arg1>(serviceType: Service.Type, arg1: Arg1) -> Service? {
        return resolve(serviceType, arg1: arg1, name: nil)
    }
    
    public func resolve<Service, Arg1, Arg2>(serviceType: Service.Type, arg1: Arg1, arg2: Arg2) -> Service? {
        return resolve(serviceType, arg1: arg1, arg2: arg2, name: nil)
    }
    
    public func resolve<Service>(serviceType: Service.Type, name: String?) -> Service? {
        typealias FactoryType = Resolvable -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self) }
    }
    
    public func resolve<Service, Arg1>(serviceType: Service.Type, arg1: Arg1, name: String?) -> Service? {
        typealias FactoryType = (Resolvable, Arg1) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arg1) }
    }
    
    public func resolve<Service, Arg1, Arg2>(serviceType: Service.Type, arg1: Arg1, arg2: Arg2, name: String?) -> Service? {
        typealias FactoryType = (Resolvable, Arg1, Arg2) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arg1, arg2) }
    }
    
    private func resolveImpl<Service, Factory>(name: String?, invoker: Factory -> Service) -> Service? {
        resolutionPool.incrementDepth()
        defer { resolutionPool.decrementDepth() }
        
        var resolvedInstance: Service?
        let key = ServiceKey(factoryType: Factory.self, name: name)
        if let (entry, fromParent) = getEntry(key) as (ServiceEntry<Service>, Bool)? {
            switch (entry.scope) {
            case .None, .Graph:
                resolvedInstance = resolveEntry(entry, key: key, invoker: invoker)
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
                    ownEntry.instance = resolveEntry(entry, key: key, invoker: invoker) as? AnyObject
                }
                resolvedInstance = ownEntry.instance as? Service
            case .Hierarchy:
                if entry.instance == nil {
                    entry.instance = resolveEntry(entry, key: key, invoker: invoker) as? AnyObject
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
    
    private func resolveEntry<Service, Factory>(entry: ServiceEntry<Service>, key: ServiceKey, invoker: Factory -> Service) -> Service {
        let usesPool = entry.scope != .None
        if usesPool, let pooledInstance = resolutionPool[key] as? Service {
            return pooledInstance
        }
        
        let resolvedInstance = invoker(entry.factory as! Factory)
        if usesPool {
            if let pooledInstance = resolutionPool[key] as? Service {
                // An instance for the key might be added by the factory invocation.
                return pooledInstance
            }
            resolutionPool[key] = resolvedInstance as? AnyObject
        }
        
        if let completed = entry.initCompleted as? (Resolvable, Service) -> () {
            completed(self, resolvedInstance)
        }
        return resolvedInstance
    }
}
