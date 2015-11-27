//
//  Container.Arguments.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 8/18/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

//
// NOTICE:
//
// Container.Arguments.swift is generated from Container.Arguments.erb by ERB.
// Do NOT modify Container.Arguments.swift directly.
// Instead, modify Container.Arguments.erb and run `script/gencode` at the project root directory to generate the code.
//


import Foundation

// MARK: - Registeration with Arguments
extension Container {
    /// Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to register.
    ///   - name:        A registration name, which is used to differenciate from other registrations
    ///                  that have the same service and factory types.
    ///   - factory:     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                  It is invoked when the `Container` needs to instantiate the instance.
    ///                  It takes a `Resolvable` instance and 1 argument to inject dependencies to the instance,
    ///                  and returns the instance of the component type for the service.
    ///
    /// - Returns: A registered `ServiceEntry` to configure more settings with method chaining.
    public func register<Service, Arg1>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    /// Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to register.
    ///   - name:        A registration name, which is used to differenciate from other registrations
    ///                  that have the same service and factory types.
    ///   - factory:     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                  It is invoked when the `Container` needs to instantiate the instance.
    ///                  It takes a `Resolvable` instance and 2 arguments to inject dependencies to the instance,
    ///                  and returns the instance of the component type for the service.
    ///
    /// - Returns: A registered `ServiceEntry` to configure more settings with method chaining.
    public func register<Service, Arg1, Arg2>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1, Arg2) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    /// Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to register.
    ///   - name:        A registration name, which is used to differenciate from other registrations
    ///                  that have the same service and factory types.
    ///   - factory:     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                  It is invoked when the `Container` needs to instantiate the instance.
    ///                  It takes a `Resolvable` instance and 3 arguments to inject dependencies to the instance,
    ///                  and returns the instance of the component type for the service.
    ///
    /// - Returns: A registered `ServiceEntry` to configure more settings with method chaining.
    public func register<Service, Arg1, Arg2, Arg3>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1, Arg2, Arg3) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    /// Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to register.
    ///   - name:        A registration name, which is used to differenciate from other registrations
    ///                  that have the same service and factory types.
    ///   - factory:     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                  It is invoked when the `Container` needs to instantiate the instance.
    ///                  It takes a `Resolvable` instance and 4 arguments to inject dependencies to the instance,
    ///                  and returns the instance of the component type for the service.
    ///
    /// - Returns: A registered `ServiceEntry` to configure more settings with method chaining.
    public func register<Service, Arg1, Arg2, Arg3, Arg4>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1, Arg2, Arg3, Arg4) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    /// Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to register.
    ///   - name:        A registration name, which is used to differenciate from other registrations
    ///                  that have the same service and factory types.
    ///   - factory:     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                  It is invoked when the `Container` needs to instantiate the instance.
    ///                  It takes a `Resolvable` instance and 5 arguments to inject dependencies to the instance,
    ///                  and returns the instance of the component type for the service.
    ///
    /// - Returns: A registered `ServiceEntry` to configure more settings with method chaining.
    public func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    /// Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to register.
    ///   - name:        A registration name, which is used to differenciate from other registrations
    ///                  that have the same service and factory types.
    ///   - factory:     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                  It is invoked when the `Container` needs to instantiate the instance.
    ///                  It takes a `Resolvable` instance and 6 arguments to inject dependencies to the instance,
    ///                  and returns the instance of the component type for the service.
    ///
    /// - Returns: A registered `ServiceEntry` to configure more settings with method chaining.
    public func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    /// Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to register.
    ///   - name:        A registration name, which is used to differenciate from other registrations
    ///                  that have the same service and factory types.
    ///   - factory:     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                  It is invoked when the `Container` needs to instantiate the instance.
    ///                  It takes a `Resolvable` instance and 7 arguments to inject dependencies to the instance,
    ///                  and returns the instance of the component type for the service.
    ///
    /// - Returns: A registered `ServiceEntry` to configure more settings with method chaining.
    public func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    /// Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to register.
    ///   - name:        A registration name, which is used to differenciate from other registrations
    ///                  that have the same service and factory types.
    ///   - factory:     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                  It is invoked when the `Container` needs to instantiate the instance.
    ///                  It takes a `Resolvable` instance and 8 arguments to inject dependencies to the instance,
    ///                  and returns the instance of the component type for the service.
    ///
    /// - Returns: A registered `ServiceEntry` to configure more settings with method chaining.
    public func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    /// Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to register.
    ///   - name:        A registration name, which is used to differenciate from other registrations
    ///                  that have the same service and factory types.
    ///   - factory:     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                  It is invoked when the `Container` needs to instantiate the instance.
    ///                  It takes a `Resolvable` instance and 9 arguments to inject dependencies to the instance,
    ///                  and returns the instance of the component type for the service.
    ///
    /// - Returns: A registered `ServiceEntry` to configure more settings with method chaining.
    public func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    /// Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to register.
    ///   - name:        A registration name, which is used to differenciate from other registrations
    ///                  that have the same service and factory types.
    ///   - factory:     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                  It is invoked when the `Container` needs to instantiate the instance.
    ///                  It takes a `Resolvable` instance and 10 arguments to inject dependencies to the instance,
    ///                  and returns the instance of the component type for the service.
    ///
    /// - Returns: A registered `ServiceEntry` to configure more settings with method chaining.
    public func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    /// Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to register.
    ///   - name:        A registration name, which is used to differenciate from other registrations
    ///                  that have the same service and factory types.
    ///   - factory:     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                  It is invoked when the `Container` needs to instantiate the instance.
    ///                  It takes a `Resolvable` instance and 11 arguments to inject dependencies to the instance,
    ///                  and returns the instance of the component type for the service.
    ///
    /// - Returns: A registered `ServiceEntry` to configure more settings with method chaining.
    public func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    /// Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to register.
    ///   - name:        A registration name, which is used to differenciate from other registrations
    ///                  that have the same service and factory types.
    ///   - factory:     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                  It is invoked when the `Container` needs to instantiate the instance.
    ///                  It takes a `Resolvable` instance and 12 arguments to inject dependencies to the instance,
    ///                  and returns the instance of the component type for the service.
    ///
    /// - Returns: A registered `ServiceEntry` to configure more settings with method chaining.
    public func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11, Arg12>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11, Arg12) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

}

// MARK: - Resolvable with Arguments
extension Container {
    /// Retrieves the instance with the specified service type and 1 argument to the factory closure.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - argument:   1 argument to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and 1 argument is found in the `Container`.
    public func resolve<Service, Arg1>(
        serviceType: Service.Type,
        argument: Arg1) -> Service?
    {
        return resolve(serviceType, name: nil, argument: argument)
    }

    /// Retrieves the instance with the specified service type, 1 argument to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - argument:   1 argument to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            1 argument and name is found in the `Container`.
    public func resolve<Service, Arg1>(
        serviceType: Service.Type,
        name: String?,
        argument: Arg1) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, argument) }
    }

    /// Retrieves the instance with the specified service type and tuple of 2 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - arguments:   Tuple of 2 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and tuple of 2 arguments is found in the `Container`.
    public func resolve<Service, Arg1, Arg2>(
        serviceType: Service.Type,
        arguments: (Arg1, Arg2)) -> Service?
    {
        return resolve(serviceType, name: nil, arguments: arguments)
    }

    /// Retrieves the instance with the specified service type, tuple of 2 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   Tuple of 2 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            tuple of 2 arguments and name is found in the `Container`.
    public func resolve<Service, Arg1, Arg2>(
        serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2)) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1, Arg2) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arguments.0, arguments.1) }
    }

    /// Retrieves the instance with the specified service type and tuple of 3 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - arguments:   Tuple of 3 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and tuple of 3 arguments is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3>(
        serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3)) -> Service?
    {
        return resolve(serviceType, name: nil, arguments: arguments)
    }

    /// Retrieves the instance with the specified service type, tuple of 3 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   Tuple of 3 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            tuple of 3 arguments and name is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3>(
        serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3)) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1, Arg2, Arg3) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arguments.0, arguments.1, arguments.2) }
    }

    /// Retrieves the instance with the specified service type and tuple of 4 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - arguments:   Tuple of 4 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and tuple of 4 arguments is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4>(
        serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3, Arg4)) -> Service?
    {
        return resolve(serviceType, name: nil, arguments: arguments)
    }

    /// Retrieves the instance with the specified service type, tuple of 4 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   Tuple of 4 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            tuple of 4 arguments and name is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4>(
        serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3, Arg4)) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1, Arg2, Arg3, Arg4) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arguments.0, arguments.1, arguments.2, arguments.3) }
    }

    /// Retrieves the instance with the specified service type and tuple of 5 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - arguments:   Tuple of 5 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and tuple of 5 arguments is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(
        serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5)) -> Service?
    {
        return resolve(serviceType, name: nil, arguments: arguments)
    }

    /// Retrieves the instance with the specified service type, tuple of 5 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   Tuple of 5 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            tuple of 5 arguments and name is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(
        serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5)) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arguments.0, arguments.1, arguments.2, arguments.3, arguments.4) }
    }

    /// Retrieves the instance with the specified service type and tuple of 6 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - arguments:   Tuple of 6 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and tuple of 6 arguments is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(
        serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6)) -> Service?
    {
        return resolve(serviceType, name: nil, arguments: arguments)
    }

    /// Retrieves the instance with the specified service type, tuple of 6 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   Tuple of 6 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            tuple of 6 arguments and name is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(
        serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6)) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arguments.0, arguments.1, arguments.2, arguments.3, arguments.4, arguments.5) }
    }

    /// Retrieves the instance with the specified service type and tuple of 7 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - arguments:   Tuple of 7 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and tuple of 7 arguments is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(
        serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7)) -> Service?
    {
        return resolve(serviceType, name: nil, arguments: arguments)
    }

    /// Retrieves the instance with the specified service type, tuple of 7 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   Tuple of 7 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            tuple of 7 arguments and name is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(
        serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7)) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arguments.0, arguments.1, arguments.2, arguments.3, arguments.4, arguments.5, arguments.6) }
    }

    /// Retrieves the instance with the specified service type and tuple of 8 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - arguments:   Tuple of 8 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and tuple of 8 arguments is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(
        serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8)) -> Service?
    {
        return resolve(serviceType, name: nil, arguments: arguments)
    }

    /// Retrieves the instance with the specified service type, tuple of 8 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   Tuple of 8 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            tuple of 8 arguments and name is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(
        serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8)) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arguments.0, arguments.1, arguments.2, arguments.3, arguments.4, arguments.5, arguments.6, arguments.7) }
    }

    /// Retrieves the instance with the specified service type and tuple of 9 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - arguments:   Tuple of 9 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and tuple of 9 arguments is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(
        serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9)) -> Service?
    {
        return resolve(serviceType, name: nil, arguments: arguments)
    }

    /// Retrieves the instance with the specified service type, tuple of 9 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   Tuple of 9 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            tuple of 9 arguments and name is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(
        serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9)) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arguments.0, arguments.1, arguments.2, arguments.3, arguments.4, arguments.5, arguments.6, arguments.7, arguments.8) }
    }

    /// Retrieves the instance with the specified service type and tuple of 10 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - arguments:   Tuple of 10 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and tuple of 10 arguments is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10>(
        serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10)) -> Service?
    {
        return resolve(serviceType, name: nil, arguments: arguments)
    }

    /// Retrieves the instance with the specified service type, tuple of 10 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   Tuple of 10 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            tuple of 10 arguments and name is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10>(
        serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10)) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arguments.0, arguments.1, arguments.2, arguments.3, arguments.4, arguments.5, arguments.6, arguments.7, arguments.8, arguments.9) }
    }

    /// Retrieves the instance with the specified service type and tuple of 11 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - arguments:   Tuple of 11 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and tuple of 11 arguments is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11>(
        serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11)) -> Service?
    {
        return resolve(serviceType, name: nil, arguments: arguments)
    }

    /// Retrieves the instance with the specified service type, tuple of 11 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   Tuple of 11 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            tuple of 11 arguments and name is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11>(
        serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11)) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arguments.0, arguments.1, arguments.2, arguments.3, arguments.4, arguments.5, arguments.6, arguments.7, arguments.8, arguments.9, arguments.10) }
    }

    /// Retrieves the instance with the specified service type and tuple of 12 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - arguments:   Tuple of 12 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and tuple of 12 arguments is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11, Arg12>(
        serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11, Arg12)) -> Service?
    {
        return resolve(serviceType, name: nil, arguments: arguments)
    }

    /// Retrieves the instance with the specified service type, tuple of 12 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   Tuple of 12 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            tuple of 12 arguments and name is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11, Arg12>(
        serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11, Arg12)) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11, Arg12) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arguments.0, arguments.1, arguments.2, arguments.3, arguments.4, arguments.5, arguments.6, arguments.7, arguments.8, arguments.9, arguments.10, arguments.11) }
    }

}
