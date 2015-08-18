//
//  Container.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/23/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Foundation

public final class Container {
    public static let defaultContainer = Container()
    private var services = [ServiceKey: ServiceEntryBase]()
    private let parent: Container?
    private var resolutionPool = ResolutionPool()
    
    public init() {
        self.parent = nil
    }
    
    public init(parent: Container) {
        self.parent = parent
    }
    
    public func removeAll() {
        services.removeAll()
    }
    
    public func register<Service>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: Resolvable -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    internal func registerImpl<Service, Factory>(serviceType: Service.Type, factory: Factory, name: String?) -> ServiceEntry<Service> {
        let key = ServiceKey(factoryType: factory.dynamicType, name: name)
        let entry = ServiceEntry(serviceType: serviceType, factory: factory)
        services[key] = entry
        return entry
    }
}

// MARK: - Extension for Storyboard
extension Container {
    public func registerForStoryboard<C: Controller>(controllerType: C.Type, name: String? = nil, initCompleted: (Resolvable, C) -> ()) {
        let key = ServiceKey(factoryType: controllerType, name: name)
        let entry = ServiceEntry(serviceType: controllerType)
        
        // Swift 1.2 workaround. Not needed on Swift 2.
        let castedClosure: (Resolvable, Controller) -> () = { r, c in initCompleted(r, c as! C) }
        
        entry.initCompleted = castedClosure
        services[key] = entry
    }
    
    internal func runInitCompleted<C: Controller>(controllerType: C.Type, controller: C, name: String? = nil) {
        resolutionPool.incrementDepth()
        
        let key = ServiceKey(factoryType: controllerType, name: name)
        if let entry = getEntry(key) {
            resolutionPool[key] = controller as Any
            
            // Swift 1.2 workaround casting initCompleted to (Resolvable, Controller) -> (), not (Resolvable, C) -> ()
            if let completed = entry.initCompleted as? (Resolvable, Controller) -> () {
                completed(self, controller)
            }
        }
        
        resolutionPool.decrementDepth()
    }
    
    private func getEntry(key: ServiceKey) -> ServiceEntryBase? {
        return services[key] ?? self.parent?.getEntry(key)
    }
}

// MARK: - Resolvable
extension Container: Resolvable {
    public func resolve<Service>(
        serviceType: Service.Type) -> Service?
    {
        return resolve(serviceType, name: nil)
    }
    
    public func resolve<Service>(
        serviceType: Service.Type,
        name: String?) -> Service?
    {
        typealias FactoryType = Resolvable -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self) }
    }
    
    internal func resolveImpl<Service, Factory>(name: String?, invoker: Factory -> Service) -> Service? {
        resolutionPool.incrementDepth()
        
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
                    ownEntry.instance = resolveEntry(entry, key: key, invoker: invoker) as Any
                }
                resolvedInstance = ownEntry.instance as? Service
            case .Hierarchy:
                if entry.instance == nil {
                    entry.instance = resolveEntry(entry, key: key, invoker: invoker) as Any
                }
                resolvedInstance = entry.instance as? Service
            }
        }
        
        resolutionPool.decrementDepth()
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
            resolutionPool[key] = resolvedInstance as Any
        }
        
        if let completed = entry.initCompleted as? (Resolvable, Service) -> () {
            completed(self, resolvedInstance)
        }
        return resolvedInstance
    }
}
