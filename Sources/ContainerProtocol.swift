//
//  ContainerProtocol.swift
//  Swinject
//
//  Created by Stijn on 16/05/2018.
//  Copyright © 2018 Swinject Contributors. All rights reserved.
//

import Foundation

/// These are functions made so we can have a ContainerProtocol instead of a final class.
public protocol ServiceGetterProtocol {
    func getRegistrations() -> [ServiceKey: ServiceEntryProtocol]
    func getEntry(for key: ServiceKey) -> ServiceEntryProtocol?
}

public protocol ContainerProtocol: Resolver, ServiceGetterProtocol, ContainerArgumentable {
    var lock: SpinLock { get }
    
    func removeAll()
    /// Discards instances for services registered in the given `ObjectsScopeProtocol`.
    ///
    /// **Example usage:**
    ///     container.resetObjectScope(ObjectScope.container)
    ///
    /// - Parameters:
    ///     - objectScope: All instances registered in given `ObjectsScopeProtocol` will be discarded.
    func resetObjectScope(_ objectScope: ObjectScopeProtocol)
    /// Discards instances for services registered in the given `ObjectsScope`. It performs the same operation
    /// as `resetObjectScope(_:ObjectScopeProtocol)`, but provides more convenient usage syntax.
    ///
    /// **Example usage:**
    ///     container.resetObjectScope(.container)
    ///
    /// - Parameters:
    ///     - objectScope: All instances registered in given `ObjectsScope` will be discarded.
    func resetObjectScope(_ objectScope: ObjectScope)
    
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
    func register<Service>(
        _ serviceType: Service.Type,
        name: String?,
        factory: @escaping (Resolver) -> Service
    ) -> ServiceEntry<Service>
    
    /// Duplicate but without name because protocols do not allow default arguments
    @discardableResult
    func register<Service>(
        _ serviceType: Service.Type,
        factory: @escaping (Resolver) -> Service
    ) -> ServiceEntry<Service>

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
    func _register<Service, Arguments>(
            _ serviceType: Service.Type,
            factory: @escaping (Arguments) -> Any,
            name: String?,
            option: ServiceKeyOption?
    ) -> ServiceEntry<Service>

    /// Returns a synchronized view of the container for thread safety.
    /// The returned container is `Resolver` type. Call this method after you finish all service registrations
    /// to the original container.
    ///
    /// - Returns: A synchronized container as `Resolver`.
    func synchronize() -> Resolver

    /// Adds behavior to the container. `Behavior.container(_:didRegisterService:withName:)` will be invoked for
    /// each service registered to the `container` **after** the behavior has been added.
    ///
    /// - Parameters:
    ///     - behavior: Behavior to be added to the container
    func addBehavior(_ behavior: Behavior)
}

/// Manualy added this, should be done by a script script/gencode but had no time to that
public protocol ContainerArgumentable {
    
    @discardableResult
    func register<Service, Arg1>(
        _ serviceType: Service.Type,
        name: String?,
        factory: @escaping (Resolver, Arg1) -> Service) -> ServiceEntry<Service>

    @discardableResult
    func register<Service, Arg1>(
        _ serviceType: Service.Type,
        factory: @escaping (Resolver, Arg1) -> Service) -> ServiceEntry<Service>

    @discardableResult
    func register<Service, Arg1, Arg2>(
        _ serviceType: Service.Type,
        name: String?,
        factory: @escaping (Resolver, Arg1, Arg2) -> Service) -> ServiceEntry<Service>

    @discardableResult
    func register<Service, Arg1, Arg2>(
        _ serviceType: Service.Type,
        factory: @escaping (Resolver, Arg1, Arg2) -> Service) -> ServiceEntry<Service>

    @discardableResult
    func register<Service, Arg1, Arg2, Arg3>(
        _ serviceType: Service.Type,
        name: String?,
        factory: @escaping (Resolver, Arg1, Arg2, Arg3) -> Service) -> ServiceEntry<Service>
    
    @discardableResult
    func register<Service, Arg1, Arg2, Arg3>(
        _ serviceType: Service.Type,
        factory: @escaping (Resolver, Arg1, Arg2, Arg3) -> Service) -> ServiceEntry<Service>
    
    // MARK: - Resolver with Arguments
        func resolve<Service, Arg1>(
            _ serviceType: Service.Type,
            argument: Arg1) -> Service?
 
        func resolve<Service, Arg1>(
            _ serviceType: Service.Type,
            name: String?,
            argument: Arg1) -> Service?
 
        func resolve<Service, Arg1, Arg2>(
            _ serviceType: Service.Type,
            arguments arg1: Arg1, _ arg2: Arg2) -> Service?

        func resolve<Service, Arg1, Arg2>(
            _ serviceType: Service.Type,
            name: String?,
            arguments arg1: Arg1, _ arg2: Arg2) -> Service?

        func resolve<Service, Arg1, Arg2, Arg3>(
            _ serviceType: Service.Type,
            arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> Service?

        func resolve<Service, Arg1, Arg2, Arg3>(
            _ serviceType: Service.Type,
            name: String?,
            arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> Service?

        func resolve<Service, Arg1, Arg2, Arg3, Arg4>(
            _ serviceType: Service.Type,
            arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) -> Service?
    
}
