//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Foundation

/// The ``Container`` class represents a dependency injection container, which stores registrations of services
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
    internal var services = ThreadSafeDictionary<ServiceKey, ServiceEntryProtocol>()
    private let parent: Container? // Used by HierarchyObjectScope
    private var resolutionDepth = 0
    private let debugHelper: DebugHelper
    private let defaultObjectScope: ObjectScope
    private let synchronized: Bool
    internal var currentObjectGraph: GraphIdentifier?
    internal var graphInstancesInFlight = [ServiceEntryProtocol]()
    internal let lock: RecursiveLock // Used by SynchronizedResolver.
    internal var behaviors = [Behavior]()

    internal init(
        parent: Container? = nil,
        debugHelper: DebugHelper,
        defaultObjectScope: ObjectScope = .graph,
        synchronized: Bool = false
    ) {
        self.parent = parent
        self.debugHelper = debugHelper
        lock = parent.map(\.lock) ?? RecursiveLock()
        self.defaultObjectScope = defaultObjectScope
        self.synchronized = synchronized
    }

    /// Instantiates a ``Container``
    ///
    /// - Parameters
    ///     - parent: The optional parent ``Container``.
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
        syncIfEnabled { services.removeAll() }
    }

    /// Discards instances for services registered in the given `ObjectsScopeProtocol`.
    ///
    /// **Example usage:**
    ///     container.resetObjectScope(ObjectScope.container)
    ///
    /// - Parameters:
    ///     - objectScope: All instances registered in given `ObjectsScopeProtocol` will be discarded.
    public func resetObjectScope(_ objectScope: ObjectScopeProtocol) {
        syncIfEnabled {
            services.values
                .filter { $0.objectScope === objectScope }
                .forEach { $0.storage.instance = nil }
            parent?.resetObjectScope(objectScope)
        }
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
    /// Discards instances for a given service registered in the given `ObjectsScopeProtocol`.
    ///
    /// **Example usage:**
    ///     container.resetObjectScope(ObjectScope.container, MyService.Type)
    ///
    /// - Parameters:
    ///     - objectScope: instances registered in given `ObjectsScopeProtocol`
    ///     - serviceType: and with given serviceType  will be discarded.
    public func resetObjectScope(_ objectScope: ObjectScopeProtocol, serviceType: Any.Type) {
        syncIfEnabled {
            let matchingServices = services.keys
                .filter { $0.serviceType == serviceType }
                .compactMap { services[$0] }

            if matchingServices.isEmpty { return }

            matchingServices
                .filter { $0.objectScope === objectScope }
                .forEach { $0.storage.instance = nil }

            parent?.resetObjectScope(objectScope, serviceType: serviceType)
        }
    }
    /// Discards instances for  a given service registered in the given `ObjectsScope`. It performs the same operation
    /// as `resetObjectScope(_:ObjectScopeProtocol, serviceType: Any.Type)`,
    /// but provides more convenient usage syntax.
    ///
    /// **Example usage:**
    ///     container.resetObjectScope(.container, servieType: MyService.self)
    ///
    /// - Parameters:
    ///     - objectScope:  Instances registered in given `ObjectsScope`
    ///     - serviceType:  and with given serviceType will be discarded.
    public func resetObjectScope(_ objectScope: ObjectScope, serviceType: Any.Type) {
        resetObjectScope(objectScope as ObjectScopeProtocol, serviceType: serviceType)
    }
    /// Adds a registration for the specified service with the factory closure to specify how the service is
    /// resolved with dependencies.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to register.
    ///   - name:        A registration name, which is used to differentiate from other registrations
    ///                  that have the same service and factory types.
    ///   - factory:     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                  It is invoked when the ``Container`` needs to instantiate the instance.
    ///                  It takes a ``Resolver`` to inject dependencies to the instance,
    ///                  and returns the instance of the component type for the service.
    ///
    /// - Returns: A registered ``ServiceEntry`` to configure more settings with method chaining.
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
    ///                  It is invoked when the ``Container`` needs to instantiate the instance.
    ///                  It takes a ``Resolver`` to inject dependencies to the instance,
    ///                  and returns the instance of the component type for the service.
    ///   - name:        A registration name.
    ///   - option:      A service key option for an extension/plugin.
    ///
    /// - Returns: A registered ``ServiceEntry`` to configure more settings with method chaining.
    @discardableResult
    // swiftlint:disable:next identifier_name
    public func _register<Service, Arguments>(
        _ serviceType: Service.Type,
        factory: @escaping (Arguments) -> Any,
        name: String? = nil,
        option: ServiceKeyOption? = nil
    ) -> ServiceEntry<Service> {
        syncIfEnabled {
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
    }

    /// Returns a synchronized view of the container for thread safety.
    /// The returned container is ``Resolver`` type and is not the original container. Continuing to add more
    /// registrations after calling `synchronize()` will result in different graph scope.
    ///
    /// It is recommended to call this method after you finish all service registrations to the original container.
    ///
    /// - Returns: A synchronized container as ``Resolver``.
    public func synchronize() -> Resolver {
        return Container(parent: self,
                         debugHelper: debugHelper,
                         defaultObjectScope: defaultObjectScope,
                         synchronized: true)
    }

    /// Adds behavior to the container. `Behavior.container(_:didRegisterService:withName:)` will be invoked for
    /// each service registered to the `container` **after** the behavior has been added.
    ///
    /// - Parameters:
    ///     - behavior: Behavior to be added to the container
    public func addBehavior(_ behavior: Behavior) {
        syncIfEnabled {
            behaviors.append(behavior)
        }
    }

    /// Check if a `Service` of a given type and name has already been registered.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to compare.
    ///   - name:        A registration name, which is used to differentiate from other registrations
    ///                  that have the same service and factory types.
    ///
    /// - Returns: A  `Bool`  which represents whether or not the `Service` has been registered.
    public func hasAnyRegistration<Service>(
        of serviceType: Service.Type,
        name: String? = nil
    ) -> Bool {
        syncIfEnabled {
            services.contains { key, _ in
                key.serviceType == serviceType && key.name == name
            } || parent?.hasAnyRegistration(of: serviceType, name: name) == true
        }
    }
    
    /// Applies a given GraphIdentifier across resolves in the provided closure.
    /// - Parameters:
    ///   - identifier: Graph scope to use
    ///   - closure: Actions to execute within the Container
    /// - Returns: Any value you return (Void otherwise) within the function call.
    public func withObjectGraph<T>(_ identifier: GraphIdentifier, closure: (Container) throws -> T) rethrows -> T {
        try syncIfEnabled {
            let graphIdentifier = currentObjectGraph
            defer { 
                self.currentObjectGraph = graphIdentifier
                decrementResolutionDepth()
            }
            self.currentObjectGraph = identifier
            incrementResolutionDepth()
            return try closure(self)
        }
    }

    /// Restores the object graph to match the given identifier.
    /// Not synchronized, use lock to edit safely.
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
        // No need to use weak self since the resolution will be executed before
        // this function exits.
        syncIfEnabled {
            var resolvedInstance: Service?
            let key = ServiceKey(serviceType: Service.self, argumentsType: Arguments.self, name: name, option: option)

            if key == Self.graphIdentifierKey {
                return currentObjectGraph as? Service
            }

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
            let factory = { [weak self] (graphIdentifier: GraphIdentifier?) -> Any? in
                self?.syncIfEnabled { [weak self] () -> Any? in
                    guard let self else { return nil }
                    let originGraph = self.currentObjectGraph
                    defer { originGraph.map { self.restoreObjectGraph($0) } }
                    if let graphIdentifier = graphIdentifier {
                        self.restoreObjectGraph(graphIdentifier)
                    }
                    return self.resolve(entry: entry, invoker: invoker) as Any?
                }
            }
            return wrapper.init(inContainer: self, withInstanceFactory: factory) as? Wrapper
        } else {
            return wrapper.init(inContainer: self, withInstanceFactory: nil) as? Wrapper
        }
    }

    fileprivate func getRegistrations() -> [ServiceKey: ServiceEntryProtocol] {
        var registrations = parent?.getRegistrations() ?? [:]
        services.forEachRead { key, value in registrations[key] = value }
        return registrations
    }

    fileprivate var maxResolutionDepth: Int { return 200 }

    fileprivate func incrementResolutionDepth() {
        parent?.incrementResolutionDepth()
        if resolutionDepth == 0, currentObjectGraph == nil {
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
        graphInstancesInFlight.forEach { $0.storage.graphResolutionCompleted() }
        graphInstancesInFlight.removeAll(keepingCapacity: true)
        currentObjectGraph = nil
    }
}

// MARK: - Resolver

extension Container: Resolver {
    /// Retrieves the instance with the specified service type.
    ///
    /// - Parameter serviceType: The service type to resolve.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            is found in the ``Container``.
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
    ///            is found in the ``Container``.
    public func resolve<Service>(_: Service.Type, name: String?) -> Service? {
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
        invoker: @escaping (Factory) -> Any
    ) -> Service? {
        self.incrementResolutionDepth()
        defer { self.decrementResolutionDepth() }

        guard let currentObjectGraph = self.currentObjectGraph else {
            fatalError("If accessing container from multiple threads, make sure to use a synchronized resolver.")
        }

        if let persistedInstance = self.persistedInstance(Service.self, from: entry, in: currentObjectGraph) {
            return persistedInstance
        }

        let resolvedInstance = invoker(entry.factory as! Factory)
        if let persistedInstance = self.persistedInstance(Service.self, from: entry, in: currentObjectGraph) {
            // An instance for the key might be added by the factory invocation.
            return persistedInstance
        }
        entry.storage.setInstance(resolvedInstance as Any, inGraph: currentObjectGraph)
        graphInstancesInFlight.append(entry)

        if let completed = entry.initCompleted as? (Resolver, Any) -> Void,
           let resolvedInstance = resolvedInstance as? Service {
            completed(self, resolvedInstance)
        }

        return resolvedInstance as? Service
    }

    /// Retrieves the instance with the specified service type and arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - argument:    Arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and arguments is found in the ``Container``.
    public func resolve<Service, each Arg>(
        _ serviceType: Service.Type,
        argument: repeat each Arg
    ) -> Service? {
        return resolve(serviceType, name: nil, argument: repeat each argument)
    }

    /// Retrieves the instance with the specified service type, arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - argument:    Arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            arguments and name is found in the ``Container``.
    public func resolve<Service, each Arg>(
        _ serviceType: Service.Type,
        name: String?,
        argument: repeat each Arg
    ) -> Service? {
        typealias FactoryType = ((Resolver, repeat each Arg)) -> Any
        return _resolve(name: name) { (factory: FactoryType) in factory((self, repeat each argument)) }
    }


    private func persistedInstance<Service>(
        _: Service.Type, from entry: ServiceEntryProtocol, in graph: GraphIdentifier
    ) -> Service? {
        if let instance = entry.storage.instance(inGraph: graph), let service = instance as? Service {
            return service
        } else {
            return nil
        }
    }

    @inline(__always)
    @discardableResult
    internal func syncIfEnabled<T>(_ action: () throws -> T) rethrows -> T {
        try synchronized ? lock.sync(action) : action()
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

// MARK: Constants

private extension Container {
    static let graphIdentifierKey: ServiceKey = {
        let key = ServiceKey(serviceType: GraphIdentifier.self, argumentsType: Resolver.self)
        return key
    }()
}
