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
/// where `A` and `X` are protocols, `B` is a type conforming `A`, and `Y` is a type conforming `X` 
/// and depending on `A`.
public final class Container {
    internal var services = [ServiceKey: ServiceEntryProtocol]()
    fileprivate let parent: Container? // Used by HierarchyObjectScope
    fileprivate var resolutionDepth = 0
    fileprivate let debugHelper: DebugHelper
    fileprivate let defaultObjectScope: ObjectScope
    internal var currentObjectGraph: GraphIdentifier?
    internal let lock: SpinLock // Used by SynchronizedResolver.
    internal var behaviors = [Behavior]()

    internal init(
        parent: Container? = nil,
        debugHelper: DebugHelper,
        defaultObjectScope: ObjectScope = .graph) {
        self.parent = parent
        self.debugHelper = debugHelper
        self.lock = parent.map { $0.lock } ?? SpinLock()
        self.defaultObjectScope = defaultObjectScope
    }

    /// Instantiates a `Container`
    ///
    /// - Parameters
    ///     - parent: The optional parent `Container`.
    ///     - defaultObjectScope: Default object scope (graph if no scope is injected)
    ///     - behaviors: List of behaviors to be added to the container
    ///     - registeringClosure: The closure registering services to the new container instance.
    ///
    /// - Remark: Compile time may be long if you pass a long closure to this initializer.
    ///           Use `init()` or `init(parent:)` instead.
    public convenience init(
        parent: Container? = nil,
        defaultObjectScope: ObjectScope = .graph,
        behaviors: [Behavior] = [],
        registeringClosure: (Container) -> Void = { _ in }
    ) {
        self.init(parent: parent, debugHelper: LoggingDebugHelper(), defaultObjectScope: defaultObjectScope)
        behaviors.forEach(addBehavior)
        registeringClosure(self)
    }

    /// Removes all registrations in the container.
    public func removeAll() {
        services.removeAll()
    }

    /// Discards instances for services registered in the given `ObjectsScopeProtocol`.
    ///
    /// **Example usage:**
    ///     container.resetObjectScope(ObjectScope.container)
    ///
    /// - Parameters:
    ///     - objectScope: All instances registered in given `ObjectsScopeProtocol` will be discarded.
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

    /// Adds a registration for the specified service with the factory closure to specify how the service is 
    /// resolved with dependencies.
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
        factory: @escaping (Resolver) -> Service
    ) -> ServiceEntry<Service> {
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
    public func _register<Service, Arguments>(
        _ serviceType: Service.Type,
        factory: @escaping (Arguments) -> Any,
        name: String? = nil,
        option: ServiceKeyOption? = nil
    ) -> ServiceEntry<Service> {
        let key = ServiceKey(serviceType: Service.self, argumentsType: Arguments.self, name: name, option: option)
        let entry = ServiceEntry(
            serviceType: serviceType,
            argumentsType: Arguments.self,
            factory: factory,
            objectScope: defaultObjectScope
        )
        entry.container = self
        services[key] = entry

        behaviors.forEach { $0.container(self, didRegisterType: serviceType, toService: entry, withName: name) }

        return entry
    }

    /// Returns a synchronized view of the container for thread safety.
    /// The returned container is `Resolver` type. Call this method after you finish all service registrations 
    /// to the original container.
    ///
    /// - Returns: A synchronized container as `Resolver`.
    public func synchronize() -> Resolver {
        return SynchronizedResolver(container: self)
    }

    /// Adds behavior to the container. `Behavior.container(_:didRegisterService:withName:)` will be invoked for
    /// each service registered to the `container` **after** the behavior has been added.
    ///
    /// - Parameters:
    ///     - behavior: Behavior to be added to the container
    public func addBehavior(_ behavior: Behavior) {
        behaviors.append(behavior)
    }

    internal func restoreObjectGraph(_ identifier: GraphIdentifier) {
        currentObjectGraph = identifier
    }
}

// MARK: - _Resolver
extension Container: _Resolver {
    // swiftlint:disable:next identifier_name
    public func _resolve<Service, Arguments>(
        name: String?,
        option: ServiceKeyOption? = nil,
        invoker: @escaping ((Arguments) -> Any) -> Any
    ) -> Service? {
        var resolvedInstance: Service?
        let key = ServiceKey(serviceType: Service.self, argumentsType: Arguments.self, name: name, option: option)

        if let entry = getEntry(for: key) {
            resolvedInstance = resolve(entry: entry, invoker: invoker)
        }

        if resolvedInstance == nil {
            resolvedInstance = resolveAsWrapper(name: name, option: option, invoker: invoker)
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

    fileprivate func resolveAsWrapper<Wrapper, Arguments>(
        name: String?,
        option: ServiceKeyOption?,
        invoker: @escaping ((Arguments) -> Any) -> Any
    ) -> Wrapper? {
        guard let wrapper = Wrapper.self as? InstanceWrapper.Type else { return nil }

        let key = ServiceKey(
            serviceType: wrapper.wrappedType, argumentsType: Arguments.self, name: name, option: option
        )

        if let entry = getEntry(for: key) {
            let factory = { [weak self] in self?.resolve(entry: entry, invoker: invoker) as Any? }
            return wrapper.init(inContainer: self, withInstanceFactory: factory) as? Wrapper
        } else {
            return wrapper.init(inContainer: self, withInstanceFactory: nil) as? Wrapper
        }
    }

    fileprivate func getRegistrations() -> [ServiceKey: ServiceEntryProtocol] {
        var registrations = parent?.getRegistrations() ?? [:]
        services.forEach { key, value in registrations[key] = value }
        return registrations
    }

    fileprivate var maxResolutionDepth: Int { return 200 }

    fileprivate func incrementResolutionDepth() {
        parent?.incrementResolutionDepth()
        if resolutionDepth == 0 && currentObjectGraph == nil {
            currentObjectGraph = GraphIdentifier()
        }
        guard resolutionDepth < maxResolutionDepth else {
            fatalError("Infinite recursive call for circular dependency has been detected. " +
                "To avoid the infinite call, 'initCompleted' handler should be used to inject circular dependency.")
        }
        resolutionDepth += 1
    }

    fileprivate func decrementResolutionDepth() {
        parent?.decrementResolutionDepth()
        assert(resolutionDepth > 0, "The depth cannot be negative.")

        resolutionDepth -= 1
        if resolutionDepth == 0 { graphResolutionCompleted() }
    }

    fileprivate func graphResolutionCompleted() {
        services.values.forEach { $0.storage.graphResolutionCompleted() }
        self.currentObjectGraph = nil
    }
}

// MARK: - Resolver
extension Container: Resolver {
    /// Retrieves the instance with the specified service type.
    ///
    /// - Parameter serviceType: The service type to resolve.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type 
    ///            is found in the `Container`.
    public func resolve<Service>(_ serviceType: Service.Type) -> Service? {
        return resolve(serviceType, name: nil)
    }

    /// Retrieves the instance with the specified service type and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type and name 
    ///            is found in the `Container`.
    public func resolve<Service>(_ serviceType: Service.Type, name: String?) -> Service? {
        return _resolve(name: name) { (factory: (Resolver) -> Any) in factory(self) }
    }

    fileprivate func getEntry(for key: ServiceKey) -> ServiceEntryProtocol? {
        if let entry = services[key] {
            return entry
        } else {
            return parent?.getEntry(for: key)
        }
    }

    fileprivate func resolve<Service, Factory>(
        entry: ServiceEntryProtocol,
        invoker: (Factory) -> Any
    ) -> Service? {
        incrementResolutionDepth()
        defer { decrementResolutionDepth() }

        guard let currentObjectGraph = currentObjectGraph else {
            fatalError("If accessing container from multiple threads, make sure to use a synchronized resolver.")
        }

        if let persistedInstance = entry.storage.instance(inGraph: currentObjectGraph), let persistedService = persistedInstance as? Service {
            return persistedService
        }

        let resolvedInstance = invoker(entry.factory as! Factory)
        if let persistedInstance = entry.storage.instance(inGraph: currentObjectGraph), let persistedService = persistedInstance as? Service {
            // An instance for the key might be added by the factory invocation.
            return persistedService
        }
        entry.storage.setInstance(resolvedInstance as Any, inGraph: currentObjectGraph)

        if  let completed = entry.initCompleted as? (Resolver, Any) -> Void,
            let resolvedInstance = resolvedInstance as? Service {

            completed(self, resolvedInstance)
        }

        return resolvedInstance as? Service
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
