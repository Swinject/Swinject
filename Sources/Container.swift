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
    internal var services = [ServiceKey: ServiceEntryProtocol]()
    private let parent: Container? // Used by HierarchyObjectScope
    private var resolutionDepth = 0
    private let debugHelper: DebugHelper
    private let defaultObjectScope: ObjectScope
    internal var currentObjectGraph: GraphIdentifier?
    internal let lock: RecursiveLock // Used by SynchronizedResolver.
    internal var behaviors = [Behavior]()

    internal init(
        parent: Container? = nil,
        debugHelper: DebugHelper,
        defaultObjectScope: ObjectScope = .graph
    ) {
        self.parent = parent
        self.debugHelper = debugHelper
        lock = parent.map { $0.lock } ?? RecursiveLock()
        self.defaultObjectScope = defaultObjectScope
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

    /// Returns a synchronized view of the container for thread safety.
    /// The returned container is ``Register`` and ``Resolver`` type.
    ///
    /// - Returns: A synchronized container as ``Register`` and ``Resolver``.
    public func synchronize() -> Register & Resolver {
        return SynchronizedContainer(container: self)
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

// MARK: - _Register

extension Container: _Register {
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
}

// MARK: - Register

extension Container: Register {
    @discardableResult
    public func register<Service>(
        _ serviceType: Service.Type,
        name: String? = nil,
        factory: @escaping (Resolver) -> Service
    ) -> ServiceEntry<Service> {
        return _register(serviceType, factory: factory, name: name)
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
        services.values.forEach { $0.storage.graphResolutionCompleted() }
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
        invoker: (Factory) -> Any
    ) -> Service? {
        incrementResolutionDepth()
        defer { decrementResolutionDepth() }

        guard let currentObjectGraph = currentObjectGraph else {
            fatalError("If accessing container from multiple threads, make sure to use a synchronized resolver.")
        }

        if let persistedInstance = persistedInstance(Service.self, from: entry, in: currentObjectGraph) {
            return persistedInstance
        }

        let resolvedInstance = invoker(entry.factory as! Factory)
        if let persistedInstance = persistedInstance(Service.self, from: entry, in: currentObjectGraph) {
            // An instance for the key might be added by the factory invocation.
            return persistedInstance
        }
        entry.storage.setInstance(resolvedInstance as Any, inGraph: currentObjectGraph)

        if let completed = entry.initCompleted as? (Resolver, Any) -> Void,
            let resolvedInstance = resolvedInstance as? Service {
            completed(self, resolvedInstance)
        }

        return resolvedInstance as? Service
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
}

// MARK: CustomStringConvertible

extension Container: CustomStringConvertible {
    public var description: String {
        return "["
            + services.map { "\n    { \($1.describeWithKey($0)) }" }.sorted().joined(separator: ",")
            + "\n]"
    }
}
