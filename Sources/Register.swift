//
//  Register.swift
//  Swinject
//
//  Created by Omar Zuniga on 12/10/21.
//  Copyright (c) 2015 Swinject Contributors. All rights reserved.
//

//
// NOTICE:
//
// Register.swift is generated from Register.erb by ERB.
// Do NOT modify Container.Arguments.swift directly.
// Instead, modify Register.erb and run `script/gencode` at the project root directory to generate the code.
//


public protocol Register {
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
    func register<Service>(
        _ serviceType: Service.Type,
        name: String?,
        factory: @escaping (Resolver) -> Service
    ) -> ServiceEntry<Service>

// MARK: - Registeration with Arguments

    /// Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to register.
    ///   - name:        A registration name, which is used to differentiate from other registrations
    ///                  that have the same service and factory types.
    ///   - factory:     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                  It is invoked when the `Container` needs to instantiate the instance.
    ///                  It takes a `Resolver` instance and 1 argument to inject dependencies to the instance,
    ///                  and returns the instance of the component type for the service.
    ///
    /// - Returns: A registered `ServiceEntry` to configure more settings with method chaining.
    @discardableResult
    func register<Service, Arg1>(
        _ serviceType: Service.Type,
        name: String?,
        factory: @escaping (Resolver, Arg1) -> Service) -> ServiceEntry<Service>
    /// Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to register.
    ///   - name:        A registration name, which is used to differentiate from other registrations
    ///                  that have the same service and factory types.
    ///   - factory:     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                  It is invoked when the `Container` needs to instantiate the instance.
    ///                  It takes a `Resolver` instance and 2 arguments to inject dependencies to the instance,
    ///                  and returns the instance of the component type for the service.
    ///
    /// - Returns: A registered `ServiceEntry` to configure more settings with method chaining.
    @discardableResult
    func register<Service, Arg1, Arg2>(
        _ serviceType: Service.Type,
        name: String?,
        factory: @escaping (Resolver, Arg1, Arg2) -> Service) -> ServiceEntry<Service>
    /// Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to register.
    ///   - name:        A registration name, which is used to differentiate from other registrations
    ///                  that have the same service and factory types.
    ///   - factory:     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                  It is invoked when the `Container` needs to instantiate the instance.
    ///                  It takes a `Resolver` instance and 3 arguments to inject dependencies to the instance,
    ///                  and returns the instance of the component type for the service.
    ///
    /// - Returns: A registered `ServiceEntry` to configure more settings with method chaining.
    @discardableResult
    func register<Service, Arg1, Arg2, Arg3>(
        _ serviceType: Service.Type,
        name: String?,
        factory: @escaping (Resolver, Arg1, Arg2, Arg3) -> Service) -> ServiceEntry<Service>
    /// Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to register.
    ///   - name:        A registration name, which is used to differentiate from other registrations
    ///                  that have the same service and factory types.
    ///   - factory:     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                  It is invoked when the `Container` needs to instantiate the instance.
    ///                  It takes a `Resolver` instance and 4 arguments to inject dependencies to the instance,
    ///                  and returns the instance of the component type for the service.
    ///
    /// - Returns: A registered `ServiceEntry` to configure more settings with method chaining.
    @discardableResult
    func register<Service, Arg1, Arg2, Arg3, Arg4>(
        _ serviceType: Service.Type,
        name: String?,
        factory: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4) -> Service) -> ServiceEntry<Service>
    /// Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to register.
    ///   - name:        A registration name, which is used to differentiate from other registrations
    ///                  that have the same service and factory types.
    ///   - factory:     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                  It is invoked when the `Container` needs to instantiate the instance.
    ///                  It takes a `Resolver` instance and 5 arguments to inject dependencies to the instance,
    ///                  and returns the instance of the component type for the service.
    ///
    /// - Returns: A registered `ServiceEntry` to configure more settings with method chaining.
    @discardableResult
    func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(
        _ serviceType: Service.Type,
        name: String?,
        factory: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4, Arg5) -> Service) -> ServiceEntry<Service>
    /// Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to register.
    ///   - name:        A registration name, which is used to differentiate from other registrations
    ///                  that have the same service and factory types.
    ///   - factory:     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                  It is invoked when the `Container` needs to instantiate the instance.
    ///                  It takes a `Resolver` instance and 6 arguments to inject dependencies to the instance,
    ///                  and returns the instance of the component type for the service.
    ///
    /// - Returns: A registered `ServiceEntry` to configure more settings with method chaining.
    @discardableResult
    func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(
        _ serviceType: Service.Type,
        name: String?,
        factory: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6) -> Service) -> ServiceEntry<Service>
    /// Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to register.
    ///   - name:        A registration name, which is used to differentiate from other registrations
    ///                  that have the same service and factory types.
    ///   - factory:     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                  It is invoked when the `Container` needs to instantiate the instance.
    ///                  It takes a `Resolver` instance and 7 arguments to inject dependencies to the instance,
    ///                  and returns the instance of the component type for the service.
    ///
    /// - Returns: A registered `ServiceEntry` to configure more settings with method chaining.
    @discardableResult
    func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(
        _ serviceType: Service.Type,
        name: String?,
        factory: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7) -> Service) -> ServiceEntry<Service>
    /// Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to register.
    ///   - name:        A registration name, which is used to differentiate from other registrations
    ///                  that have the same service and factory types.
    ///   - factory:     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                  It is invoked when the `Container` needs to instantiate the instance.
    ///                  It takes a `Resolver` instance and 8 arguments to inject dependencies to the instance,
    ///                  and returns the instance of the component type for the service.
    ///
    /// - Returns: A registered `ServiceEntry` to configure more settings with method chaining.
    @discardableResult
    func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(
        _ serviceType: Service.Type,
        name: String?,
        factory: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8) -> Service) -> ServiceEntry<Service>
    /// Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to register.
    ///   - name:        A registration name, which is used to differentiate from other registrations
    ///                  that have the same service and factory types.
    ///   - factory:     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                  It is invoked when the `Container` needs to instantiate the instance.
    ///                  It takes a `Resolver` instance and 9 arguments to inject dependencies to the instance,
    ///                  and returns the instance of the component type for the service.
    ///
    /// - Returns: A registered `ServiceEntry` to configure more settings with method chaining.
    @discardableResult
    func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(
        _ serviceType: Service.Type,
        name: String?,
        factory: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9) -> Service) -> ServiceEntry<Service>
}

//MARK: Utility methods to make name optional

public extension Register {
    @discardableResult
    func register<Service>(
        _ serviceType: Service.Type,
        factory: @escaping (Resolver) -> Service) -> ServiceEntry<Service> {
        register(serviceType, name: nil, factory: factory)
    }
    
    @discardableResult
    func register<Service, Arg1>(
        _ serviceType: Service.Type,
        factory: @escaping (Resolver, Arg1) -> Service) -> ServiceEntry<Service> {
        register(serviceType, name: nil, factory: factory)
    }
    @discardableResult
    func register<Service, Arg1, Arg2>(
        _ serviceType: Service.Type,
        factory: @escaping (Resolver, Arg1, Arg2) -> Service) -> ServiceEntry<Service> {
        register(serviceType, name: nil, factory: factory)
    }
    @discardableResult
    func register<Service, Arg1, Arg2, Arg3>(
        _ serviceType: Service.Type,
        factory: @escaping (Resolver, Arg1, Arg2, Arg3) -> Service) -> ServiceEntry<Service> {
        register(serviceType, name: nil, factory: factory)
    }
    @discardableResult
    func register<Service, Arg1, Arg2, Arg3, Arg4>(
        _ serviceType: Service.Type,
        factory: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4) -> Service) -> ServiceEntry<Service> {
        register(serviceType, name: nil, factory: factory)
    }
    @discardableResult
    func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(
        _ serviceType: Service.Type,
        factory: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4, Arg5) -> Service) -> ServiceEntry<Service> {
        register(serviceType, name: nil, factory: factory)
    }
    @discardableResult
    func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(
        _ serviceType: Service.Type,
        factory: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6) -> Service) -> ServiceEntry<Service> {
        register(serviceType, name: nil, factory: factory)
    }
    @discardableResult
    func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(
        _ serviceType: Service.Type,
        factory: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7) -> Service) -> ServiceEntry<Service> {
        register(serviceType, name: nil, factory: factory)
    }
    @discardableResult
    func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(
        _ serviceType: Service.Type,
        factory: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8) -> Service) -> ServiceEntry<Service> {
        register(serviceType, name: nil, factory: factory)
    }
    @discardableResult
    func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(
        _ serviceType: Service.Type,
        factory: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9) -> Service) -> ServiceEntry<Service> {
        register(serviceType, name: nil, factory: factory)
    }
}
