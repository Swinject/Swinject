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
    fileprivate var services = [ServiceKey: ServiceEntryProtocol]()
    fileprivate let parent: Container? // Used by HierarchyObjectScope
    fileprivate var resolutionDepth = 0
    fileprivate let debugHelper: DebugHelper
    internal let lock: SpinLock // Used by SynchronizedResolver.

    internal init(parent: Container? = nil, debugHelper: DebugHelper) {
        self.parent = parent    
        self.debugHelper = debugHelper
        self.lock = parent.map { $0.lock } ?? SpinLock()
    }
    
    /// Instantiates a `Container` with its parent `Container`. The parent is optional.
    ///
    /// - Parameter parent: The optional parent `Container`.
    public convenience init(parent: Container? = nil) {
        self.init(parent: parent, debugHelper: LoggingDebugHelper())
    }
    
    /// Instantiates a `Container` with its parent `Container` and a closure registering services. The parent is optional.
    ///
    /// - Parameters:
    ///     - parent:             The optional parent `Container`.
    ///     - registeringClosure: The closure registering services to the new container instance.
    /// - Remark: Compile time may be long if you pass a long closure to this initializer. Use `init()` or `init(parent:)` instead.
    public convenience init(parent: Container? = nil, registeringClosure: (Container) -> Void) {
        self.init(parent: parent)
        registeringClosure(self)
    }
    
    /// Removes all registrations in the container.
    public func removeAll() {
        services.removeAll()
    }

    /// Discards instances for services registered in the given `ObjectsScopeType`.
    ///
    /// **Example usage:**
    ///     container.resetObjectScope(ObjectScope.container)
    ///
    /// - Parameters:
    ///     - objectScope: All instances registered in given `ObjectsScopeType` will be discarded.
    public func resetObjectScope(_ objectScope: ObjectScopeProtocol) {
        services.values
            .filter { $0.objectScope === objectScope }
            .forEach { $0.storage.instance = nil }

        parent?.resetObjectScope(objectScope)
    }

    /// Discards instances for services registered in the given `ObjectsScope`. It performs the same operation
    /// as `resetObjectScope(_:ObjectScopeProtocol)`, but provides more convenient usage syntax.
    ///
    /// **Example usage:**
    ///     container.resetObjectScope(.container)
    ///
    /// - Parameters:
    ///     - objectScope: All instances registered in given `ObjectsScope` will be discarded.
    public func resetObjectScope(_ objectScope: ObjectScope) {
        resetObjectScope(objectScope as ObjectScopeProtocol)
    }
    
    /// Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to register.
    ///   - name:        A registration name, which is used to differentiate from other registrations
    ///                  that have the same service and factory types.
    ///   - factory:     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                  It is invoked when the `Container` needs to instantiate the instance.
    ///                  It takes a `Resolver` to inject dependencies to the instance,
    ///                  and returns the instance of the component type for the service.
    ///
    /// - Returns: A registered `ServiceEntry` to configure more settings with method chaining.
    @discardableResult
    public func register<Service>(
        _ serviceType: Service.Type,
        name: String? = nil,
        factory: @escaping (Resolver) -> Service) -> ServiceEntry<Service>
    {
        return _register(serviceType, factory: factory, name: name)
    }

    /// This method is designed for the use to extend Swinject functionality.
    /// Do NOT use this method unless you intend to write an extension or plugin to Swinject framework.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to register.
    ///   - factory:     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                  It is invoked when the `Container` needs to instantiate the instance.
    ///                  It takes a `Resolver` to inject dependencies to the instance,
    ///                  and returns the instance of the component type for the service.
    ///   - name:        A registration name.
    ///   - option:      A service key option for an extension/plugin.
    ///
    /// - Returns: A registered `ServiceEntry` to configure more settings with method chaining.
    @discardableResult
    // swiftlint:disable:next identifier_name
    public func _register<Service, Factory>(
        _ serviceType: Service.Type,
        factory: Factory,
        name: String? = nil,
        option: ServiceKeyOption? = nil) -> ServiceEntry<Service>
    {
        let key = ServiceKey(factoryType: type(of: factory), name: name, option: option)
        let entry = ServiceEntry(serviceType: serviceType, factory: factory)
        services[key] = entry
        return entry
    }
    
    /// Returns a synchronized view of the container for thread safety.
    /// The returned container is `Resolver` type. Call this method after you finish all service registrations to the original container.
    ///
    /// - Returns: A synchronized container as `Resolver`.
    public func synchronize() -> Resolver {
        return SynchronizedResolver(container: self)
    }
}

// MARK: - _Resolver
extension Container: _Resolver {
    // swiftlint:disable:next identifier_name
    public func _resolve<Service, Factory>(name: String?, option: ServiceKeyOption? = nil, invoker: (Factory) -> Service) -> Service? {
        incrementResolutionDepth()
        defer { decrementResolutionDepth() }
        
        var resolvedInstance: Service?
        let key = ServiceKey(factoryType: Factory.self, name: name, option: option)

        if let entry = getEntry(key) as ServiceEntry<Service>? {
            resolvedInstance = resolve(entry: entry, key: key, invoker: invoker)
        }

        if resolvedInstance == nil {
            debugHelper.resolutionFailed(
                serviceType: Service.self,
                key: key,
                availableRegistrations: getRegistrations()
            )
        }

        return resolvedInstance
    }

    private func getRegistrations() -> [ServiceKey: ServiceEntryProtocol] {
        var registrations = parent?.getRegistrations() ?? [:]
        services.forEach { key, value in registrations[key] = value }
        return registrations
    }

    private var maxResolutionDepth: Int { return 200 }

    private func incrementResolutionDepth() {
        guard resolutionDepth < maxResolutionDepth else {
            fatalError("Infinite recursive call for circular dependency has been detected. " +
                "To avoid the infinite call, 'initCompleted' handler should be used to inject circular dependency.")
        }
        resolutionDepth += 1
    }

    private func decrementResolutionDepth() {
        assert(resolutionDepth > 0, "The depth cannot be negative.")

        resolutionDepth -= 1
        if resolutionDepth == 0 {
            resetObjectScope(.graph)
        }
    }
}

// MARK: - Resolver
extension Container: Resolver {
    /// Retrieves the instance with the specified service type.
    ///
    /// - Parameter serviceType: The service type to resolve.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type is found in the `Container`.
    public func resolve<Service>(
        _ serviceType: Service.Type) -> Service?
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
        _ serviceType: Service.Type,
        name: String?) -> Service?
    {
        typealias FactoryType = (Resolver) -> Service
        return _resolve(name: name) { (factory: FactoryType) in factory(self) }
    }
    
    fileprivate func getEntry<Service>(_ key: ServiceKey) -> ServiceEntry<Service>? {
        if let entry = services[key] as? ServiceEntry<Service> {
            return entry
        } else {
            return parent?.getEntry(key)
        }
    }
    
    fileprivate func resolve<Service, Factory>(entry: ServiceEntry<Service>, key: ServiceKey, invoker: (Factory) -> Service) -> Service {

        if let persistedInstance = entry.storage.instance as? Service {
            return persistedInstance
        }
        
        let resolvedInstance = invoker(entry.factory as! Factory)
        if let persistedInstance = entry.storage.instance as? Service {
            // An instance for the key might be added by the factory invocation.
            return persistedInstance
        }
        entry.storage.instance = resolvedInstance as Any

        if let completed = entry.initCompleted as? (Resolver, Service) -> () {
            completed(self, resolvedInstance)
        }
        return resolvedInstance
    }
}

// MARK: CustomStringConvertible
extension Container: CustomStringConvertible {
    public var description: String {
        return "["
            + services.map { "\n    { \($1.describeWithKey($0)) }" }.sorted().joined(separator: ",")
        + "\n]"
    }
}
