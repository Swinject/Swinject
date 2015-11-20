//
//  Container.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/23/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Foundation

/// The `Container` class represents a dependency injection container, which stores registrations of services
/// and retrieves registered services with dependencies injected.
///
/// **Example to register:**
///
///     let container = Container()
///     container.register(A.self) { _ in B() }
///     container.register(X.self) { r in Y(a: r.resolve(A.self)!) }
///
/// **Example to retrieve:**
///
///     let x = container.resolve(X.self)!
///
/// where `A` and `X` are protocols, `B` is a type conforming `A`, and `Y` is a type conforming `X` and depending on `A`.
public final class Container {
    private var services = [ServiceKey: ServiceEntryBase]()
    private let parent: Container?
    private var resolutionPool = ResolutionPool()
    
    /// Instantiates a `Container` with its parent `Container`. The parent is optional.
    ///
    /// - Parameter parent: The optional parent `Container`.
    public init(parent: Container? = nil) {
        self.parent = parent
    }
    
    /// Instantiates a `Container` with its parent `Container` and a closure registering services. The parent is optional.
    ///
    /// - Parameters:
    ///     - parent:             The optional parent `Container`.
    ///     - registeringClosure: The closure registering services to the new container instance.
    public convenience init(parent: Container? = nil, @noescape registeringClosure: Container -> Void) {
        self.init(parent: parent)
        registeringClosure(self)
    }
    
    /// Instantiates a `Container` and register services from assemblies.
    ///
    /// - Parameter assemblies: Assemblies from which will be registered services.
    public convenience init(assemblies: [Assembly.Type])
    {
        self.init()
        assemblies.forEach { registerAssembly($0) }
    }
    
    /// Removes all registrations in the container.
    public func removeAll() {
        services.removeAll()
    }
    
    /// Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to register.
    ///   - name:        A registration name, which is used to differenciate from other registrations
    ///                  that have the same service and factory types.
    ///   - factory:     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                  It is invoked when the `Container` needs to instantiate the instance.
    ///                  It takes a `Resolvable` to inject dependencies to the instance,
    ///                  and returns the instance of the component type for the service.
    ///
    /// - Returns: A registered `ServiceEntry` to configure some settings fluently.
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
    
    /// Adds a registration for the services from `Assembly` in which specify how the service is resolved with dependencies.
    ///
    /// - Parameters:
    ///   - assembly:    `Assembly` from which will be registered services.
    public func registerAssembly<A:Assembly>(assembly: A.Type)
    {
        assembly.init(container: self)
    }
    
    /// Adds a registration for the services from `Definition`.
    ///
    /// - Parameters:
    ///   - definition:    `Definition` for service.
    internal func register<Service>(definition: Definition<Service>)
    {
        guard let initializer = definition.initializer else {
            fatalError("You should define initializer for \(definition.serviceType)")
        }
        
        let service = register(definition.serviceType, factory: initializer).inObjectScope(definition.scope)
        
        if let complited = definition.complited {
            service.initCompleted(complited)
        }
    }
}

// MARK: - Extension for Storyboard
#if os(iOS) || os(OSX) || os(tvOS)
extension Container {
    /// Adds a registration of the specified view or window controller that is configured in a storyboard.
    ///
    /// - Note: Do NOT explicitly resolve the controller registered by this method.
    ///         The controller is intended to be resolved by `SwinjectStoryboard` implicitly.
    ///
    /// - Parameters:
    ///   - controllerType: The controller type to register as a service type.
    ///                     The type is `UIViewController` in iOS, `NSViewController` or `NSWindowController` in OS X.
    ///   - name:           A registration name, which is used to differenciate from other registrations
    ///                     that have the same view or window controller type.
    ///   - initCompleted:  A closure to specifiy how the dependencies of the view or window controller are injected.
    ///                     It is invoked by the `Container` when the view or window controller is instantiated by `SwinjectStoryboard`.
    public func registerForStoryboard<C: Controller>(controllerType: C.Type, name: String? = nil, initCompleted: (Resolvable, C) -> ()) {
        let key = ServiceKey(factoryType: controllerType, name: name)
        let entry = ServiceEntry(serviceType: controllerType)
        
        // Xcode 7.1 workaround for Issue #10. This workaround is not necessary with Xcode 7.
        let wrappingClosure: (Resolvable, Controller) -> () = { r, c in initCompleted(r, c as! C) }
        entry.initCompleted = wrappingClosure
        
        services[key] = entry
    }
    
    internal func runInitCompleted<C: Controller>(controllerType: C.Type, controller: C, name: String? = nil) {
        resolutionPool.incrementDepth()
        defer { resolutionPool.decrementDepth() }
        
        let key = ServiceKey(factoryType: controllerType, name: name)
        if let entry = getEntry(key) {
            resolutionPool[key] = controller as Any
            
            // Xcode 7.1 workaround for Issue #10, casting initCompleted to (Resolvable, Controller) -> (), not to (Resolvable, C) -> ()
            if let completed = entry.initCompleted as? ( (Resolvable, Controller) -> () ) {
                completed(self, controller)
            }
        }
    }
    
    private func getEntry(key: ServiceKey) -> ServiceEntryBase? {
        return services[key] ?? self.parent?.getEntry(key)
    }
}
#endif

// MARK: - Resolvable
extension Container: Resolvable {
    /// Retrieves the instance with the specified service type.
    ///
    /// - Parameter serviceType: The service type to resolve.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type is found in the `Container`.
    public func resolve<Service>(
        serviceType: Service.Type) -> Service?
    {
        return resolve(serviceType, name: nil)
    }
    
    /// Retrieves the instance with the specified service type and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type and name is found in the `Container`.
    public func resolve<Service>(
        serviceType: Service.Type,
        name: String?) -> Service?
    {
        typealias FactoryType = Resolvable -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self) }
    }
    
    internal func resolveImpl<Service, Factory>(name: String?, invoker: Factory -> Service) -> Service? {
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
