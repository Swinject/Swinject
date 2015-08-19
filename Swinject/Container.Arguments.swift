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
    /// :param: serviceType The service type to register.
    /// :param: name        A registration name, which is used to differenciate from other registrations
    ///                     that have the same service and factory types.
    /// :param: factory     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                     It is invoked when the `Container` needs to instantiate the instance.
    ///                     It takes a `Resolvable` and 1 argument to inject dependencies to the instance,
    ///                     and returns the instance of the component type for the service.
    ///
    /// :returns: A registered `ServiceEntry` to configure some settings fluently.
    public func register<Service, Arg1>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    /// Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
    ///
    /// :param: serviceType The service type to register.
    /// :param: name        A registration name, which is used to differenciate from other registrations
    ///                     that have the same service and factory types.
    /// :param: factory     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                     It is invoked when the `Container` needs to instantiate the instance.
    ///                     It takes a `Resolvable` and 2 arguments to inject dependencies to the instance,
    ///                     and returns the instance of the component type for the service.
    ///
    /// :returns: A registered `ServiceEntry` to configure some settings fluently.
    public func register<Service, Arg1, Arg2>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1, Arg2) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    /// Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
    ///
    /// :param: serviceType The service type to register.
    /// :param: name        A registration name, which is used to differenciate from other registrations
    ///                     that have the same service and factory types.
    /// :param: factory     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                     It is invoked when the `Container` needs to instantiate the instance.
    ///                     It takes a `Resolvable` and 3 arguments to inject dependencies to the instance,
    ///                     and returns the instance of the component type for the service.
    ///
    /// :returns: A registered `ServiceEntry` to configure some settings fluently.
    public func register<Service, Arg1, Arg2, Arg3>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1, Arg2, Arg3) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    /// Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
    ///
    /// :param: serviceType The service type to register.
    /// :param: name        A registration name, which is used to differenciate from other registrations
    ///                     that have the same service and factory types.
    /// :param: factory     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                     It is invoked when the `Container` needs to instantiate the instance.
    ///                     It takes a `Resolvable` and 4 arguments to inject dependencies to the instance,
    ///                     and returns the instance of the component type for the service.
    ///
    /// :returns: A registered `ServiceEntry` to configure some settings fluently.
    public func register<Service, Arg1, Arg2, Arg3, Arg4>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1, Arg2, Arg3, Arg4) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    /// Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
    ///
    /// :param: serviceType The service type to register.
    /// :param: name        A registration name, which is used to differenciate from other registrations
    ///                     that have the same service and factory types.
    /// :param: factory     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                     It is invoked when the `Container` needs to instantiate the instance.
    ///                     It takes a `Resolvable` and 5 arguments to inject dependencies to the instance,
    ///                     and returns the instance of the component type for the service.
    ///
    /// :returns: A registered `ServiceEntry` to configure some settings fluently.
    public func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    /// Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
    ///
    /// :param: serviceType The service type to register.
    /// :param: name        A registration name, which is used to differenciate from other registrations
    ///                     that have the same service and factory types.
    /// :param: factory     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                     It is invoked when the `Container` needs to instantiate the instance.
    ///                     It takes a `Resolvable` and 6 arguments to inject dependencies to the instance,
    ///                     and returns the instance of the component type for the service.
    ///
    /// :returns: A registered `ServiceEntry` to configure some settings fluently.
    public func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    /// Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
    ///
    /// :param: serviceType The service type to register.
    /// :param: name        A registration name, which is used to differenciate from other registrations
    ///                     that have the same service and factory types.
    /// :param: factory     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                     It is invoked when the `Container` needs to instantiate the instance.
    ///                     It takes a `Resolvable` and 7 arguments to inject dependencies to the instance,
    ///                     and returns the instance of the component type for the service.
    ///
    /// :returns: A registered `ServiceEntry` to configure some settings fluently.
    public func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    /// Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
    ///
    /// :param: serviceType The service type to register.
    /// :param: name        A registration name, which is used to differenciate from other registrations
    ///                     that have the same service and factory types.
    /// :param: factory     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                     It is invoked when the `Container` needs to instantiate the instance.
    ///                     It takes a `Resolvable` and 8 arguments to inject dependencies to the instance,
    ///                     and returns the instance of the component type for the service.
    ///
    /// :returns: A registered `ServiceEntry` to configure some settings fluently.
    public func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    /// Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
    ///
    /// :param: serviceType The service type to register.
    /// :param: name        A registration name, which is used to differenciate from other registrations
    ///                     that have the same service and factory types.
    /// :param: factory     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                     It is invoked when the `Container` needs to instantiate the instance.
    ///                     It takes a `Resolvable` and 9 arguments to inject dependencies to the instance,
    ///                     and returns the instance of the component type for the service.
    ///
    /// :returns: A registered `ServiceEntry` to configure some settings fluently.
    public func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    /// Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
    ///
    /// :param: serviceType The service type to register.
    /// :param: name        A registration name, which is used to differenciate from other registrations
    ///                     that have the same service and factory types.
    /// :param: factory     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                     It is invoked when the `Container` needs to instantiate the instance.
    ///                     It takes a `Resolvable` and 10 arguments to inject dependencies to the instance,
    ///                     and returns the instance of the component type for the service.
    ///
    /// :returns: A registered `ServiceEntry` to configure some settings fluently.
    public func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    /// Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
    ///
    /// :param: serviceType The service type to register.
    /// :param: name        A registration name, which is used to differenciate from other registrations
    ///                     that have the same service and factory types.
    /// :param: factory     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                     It is invoked when the `Container` needs to instantiate the instance.
    ///                     It takes a `Resolvable` and 11 arguments to inject dependencies to the instance,
    ///                     and returns the instance of the component type for the service.
    ///
    /// :returns: A registered `ServiceEntry` to configure some settings fluently.
    public func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    /// Adds a registration for the specified service with the factory closure to specify how the service is resolved with dependencies.
    ///
    /// :param: serviceType The service type to register.
    /// :param: name        A registration name, which is used to differenciate from other registrations
    ///                     that have the same service and factory types.
    /// :param: factory     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                     It is invoked when the `Container` needs to instantiate the instance.
    ///                     It takes a `Resolvable` and 12 arguments to inject dependencies to the instance,
    ///                     and returns the instance of the component type for the service.
    ///
    /// :returns: A registered `ServiceEntry` to configure some settings fluently.
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
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type
    ///           and 1 argument is found in the `Container`.
    public func resolve<Service, Arg1>(
        serviceType: Service.Type,
        arg1: Arg1) -> Service?
    {
        return resolve(serviceType, arg1: arg1, name: nil)
    }

    /// Retrieves the instance with the specified service type, 1 argument to the factory closure and registration name.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: name        The registration name.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type,
    ///           1 argument and name is found in the `Container`.
    public func resolve<Service, Arg1>(
        serviceType: Service.Type,
        arg1: Arg1,
        name: String?) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arg1) }
    }

    /// Retrieves the instance with the specified service type and 2 arguments to the factory closure.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type
    ///           and 2 arguments is found in the `Container`.
    public func resolve<Service, Arg1, Arg2>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2) -> Service?
    {
        return resolve(serviceType, arg1: arg1, arg2: arg2, name: nil)
    }

    /// Retrieves the instance with the specified service type, 2 arguments to the factory closure and registration name.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: name        The registration name.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type,
    ///           2 arguments and name is found in the `Container`.
    public func resolve<Service, Arg1, Arg2>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2,
        name: String?) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1, Arg2) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arg1, arg2) }
    }

    /// Retrieves the instance with the specified service type and 3 arguments to the factory closure.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type
    ///           and 3 arguments is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3) -> Service?
    {
        return resolve(serviceType, arg1: arg1, arg2: arg2, arg3: arg3, name: nil)
    }

    /// Retrieves the instance with the specified service type, 3 arguments to the factory closure and registration name.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: name        The registration name.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type,
    ///           3 arguments and name is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3,
        name: String?) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1, Arg2, Arg3) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arg1, arg2, arg3) }
    }

    /// Retrieves the instance with the specified service type and 4 arguments to the factory closure.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type
    ///           and 4 arguments is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4) -> Service?
    {
        return resolve(serviceType, arg1: arg1, arg2: arg2, arg3: arg3, arg4: arg4, name: nil)
    }

    /// Retrieves the instance with the specified service type, 4 arguments to the factory closure and registration name.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    /// :param: name        The registration name.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type,
    ///           4 arguments and name is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4,
        name: String?) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1, Arg2, Arg3, Arg4) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arg1, arg2, arg3, arg4) }
    }

    /// Retrieves the instance with the specified service type and 5 arguments to the factory closure.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    /// :param: arg5        An argument to the factory closure as Arg5 type.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type
    ///           and 5 arguments is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5) -> Service?
    {
        return resolve(serviceType, arg1: arg1, arg2: arg2, arg3: arg3, arg4: arg4, arg5: arg5, name: nil)
    }

    /// Retrieves the instance with the specified service type, 5 arguments to the factory closure and registration name.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    /// :param: arg5        An argument to the factory closure as Arg5 type.
    /// :param: name        The registration name.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type,
    ///           5 arguments and name is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5,
        name: String?) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arg1, arg2, arg3, arg4, arg5) }
    }

    /// Retrieves the instance with the specified service type and 6 arguments to the factory closure.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    /// :param: arg5        An argument to the factory closure as Arg5 type.
    /// :param: arg6        An argument to the factory closure as Arg6 type.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type
    ///           and 6 arguments is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6) -> Service?
    {
        return resolve(serviceType, arg1: arg1, arg2: arg2, arg3: arg3, arg4: arg4, arg5: arg5, arg6: arg6, name: nil)
    }

    /// Retrieves the instance with the specified service type, 6 arguments to the factory closure and registration name.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    /// :param: arg5        An argument to the factory closure as Arg5 type.
    /// :param: arg6        An argument to the factory closure as Arg6 type.
    /// :param: name        The registration name.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type,
    ///           6 arguments and name is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6,
        name: String?) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arg1, arg2, arg3, arg4, arg5, arg6) }
    }

    /// Retrieves the instance with the specified service type and 7 arguments to the factory closure.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    /// :param: arg5        An argument to the factory closure as Arg5 type.
    /// :param: arg6        An argument to the factory closure as Arg6 type.
    /// :param: arg7        An argument to the factory closure as Arg7 type.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type
    ///           and 7 arguments is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7) -> Service?
    {
        return resolve(serviceType, arg1: arg1, arg2: arg2, arg3: arg3, arg4: arg4, arg5: arg5, arg6: arg6, arg7: arg7, name: nil)
    }

    /// Retrieves the instance with the specified service type, 7 arguments to the factory closure and registration name.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    /// :param: arg5        An argument to the factory closure as Arg5 type.
    /// :param: arg6        An argument to the factory closure as Arg6 type.
    /// :param: arg7        An argument to the factory closure as Arg7 type.
    /// :param: name        The registration name.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type,
    ///           7 arguments and name is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7,
        name: String?) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arg1, arg2, arg3, arg4, arg5, arg6, arg7) }
    }

    /// Retrieves the instance with the specified service type and 8 arguments to the factory closure.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    /// :param: arg5        An argument to the factory closure as Arg5 type.
    /// :param: arg6        An argument to the factory closure as Arg6 type.
    /// :param: arg7        An argument to the factory closure as Arg7 type.
    /// :param: arg8        An argument to the factory closure as Arg8 type.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type
    ///           and 8 arguments is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8) -> Service?
    {
        return resolve(serviceType, arg1: arg1, arg2: arg2, arg3: arg3, arg4: arg4, arg5: arg5, arg6: arg6, arg7: arg7, arg8: arg8, name: nil)
    }

    /// Retrieves the instance with the specified service type, 8 arguments to the factory closure and registration name.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    /// :param: arg5        An argument to the factory closure as Arg5 type.
    /// :param: arg6        An argument to the factory closure as Arg6 type.
    /// :param: arg7        An argument to the factory closure as Arg7 type.
    /// :param: arg8        An argument to the factory closure as Arg8 type.
    /// :param: name        The registration name.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type,
    ///           8 arguments and name is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8,
        name: String?) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8) }
    }

    /// Retrieves the instance with the specified service type and 9 arguments to the factory closure.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    /// :param: arg5        An argument to the factory closure as Arg5 type.
    /// :param: arg6        An argument to the factory closure as Arg6 type.
    /// :param: arg7        An argument to the factory closure as Arg7 type.
    /// :param: arg8        An argument to the factory closure as Arg8 type.
    /// :param: arg9        An argument to the factory closure as Arg9 type.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type
    ///           and 9 arguments is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8, arg9: Arg9) -> Service?
    {
        return resolve(serviceType, arg1: arg1, arg2: arg2, arg3: arg3, arg4: arg4, arg5: arg5, arg6: arg6, arg7: arg7, arg8: arg8, arg9: arg9, name: nil)
    }

    /// Retrieves the instance with the specified service type, 9 arguments to the factory closure and registration name.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    /// :param: arg5        An argument to the factory closure as Arg5 type.
    /// :param: arg6        An argument to the factory closure as Arg6 type.
    /// :param: arg7        An argument to the factory closure as Arg7 type.
    /// :param: arg8        An argument to the factory closure as Arg8 type.
    /// :param: arg9        An argument to the factory closure as Arg9 type.
    /// :param: name        The registration name.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type,
    ///           9 arguments and name is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8, arg9: Arg9,
        name: String?) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9) }
    }

    /// Retrieves the instance with the specified service type and 10 arguments to the factory closure.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    /// :param: arg5        An argument to the factory closure as Arg5 type.
    /// :param: arg6        An argument to the factory closure as Arg6 type.
    /// :param: arg7        An argument to the factory closure as Arg7 type.
    /// :param: arg8        An argument to the factory closure as Arg8 type.
    /// :param: arg9        An argument to the factory closure as Arg9 type.
    /// :param: arg10        An argument to the factory closure as Arg10 type.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type
    ///           and 10 arguments is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8, arg9: Arg9, arg10: Arg10) -> Service?
    {
        return resolve(serviceType, arg1: arg1, arg2: arg2, arg3: arg3, arg4: arg4, arg5: arg5, arg6: arg6, arg7: arg7, arg8: arg8, arg9: arg9, arg10: arg10, name: nil)
    }

    /// Retrieves the instance with the specified service type, 10 arguments to the factory closure and registration name.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    /// :param: arg5        An argument to the factory closure as Arg5 type.
    /// :param: arg6        An argument to the factory closure as Arg6 type.
    /// :param: arg7        An argument to the factory closure as Arg7 type.
    /// :param: arg8        An argument to the factory closure as Arg8 type.
    /// :param: arg9        An argument to the factory closure as Arg9 type.
    /// :param: arg10        An argument to the factory closure as Arg10 type.
    /// :param: name        The registration name.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type,
    ///           10 arguments and name is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8, arg9: Arg9, arg10: Arg10,
        name: String?) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10) }
    }

    /// Retrieves the instance with the specified service type and 11 arguments to the factory closure.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    /// :param: arg5        An argument to the factory closure as Arg5 type.
    /// :param: arg6        An argument to the factory closure as Arg6 type.
    /// :param: arg7        An argument to the factory closure as Arg7 type.
    /// :param: arg8        An argument to the factory closure as Arg8 type.
    /// :param: arg9        An argument to the factory closure as Arg9 type.
    /// :param: arg10        An argument to the factory closure as Arg10 type.
    /// :param: arg11        An argument to the factory closure as Arg11 type.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type
    ///           and 11 arguments is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8, arg9: Arg9, arg10: Arg10, arg11: Arg11) -> Service?
    {
        return resolve(serviceType, arg1: arg1, arg2: arg2, arg3: arg3, arg4: arg4, arg5: arg5, arg6: arg6, arg7: arg7, arg8: arg8, arg9: arg9, arg10: arg10, arg11: arg11, name: nil)
    }

    /// Retrieves the instance with the specified service type, 11 arguments to the factory closure and registration name.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    /// :param: arg5        An argument to the factory closure as Arg5 type.
    /// :param: arg6        An argument to the factory closure as Arg6 type.
    /// :param: arg7        An argument to the factory closure as Arg7 type.
    /// :param: arg8        An argument to the factory closure as Arg8 type.
    /// :param: arg9        An argument to the factory closure as Arg9 type.
    /// :param: arg10        An argument to the factory closure as Arg10 type.
    /// :param: arg11        An argument to the factory closure as Arg11 type.
    /// :param: name        The registration name.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type,
    ///           11 arguments and name is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8, arg9: Arg9, arg10: Arg10, arg11: Arg11,
        name: String?) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11) }
    }

    /// Retrieves the instance with the specified service type and 12 arguments to the factory closure.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    /// :param: arg5        An argument to the factory closure as Arg5 type.
    /// :param: arg6        An argument to the factory closure as Arg6 type.
    /// :param: arg7        An argument to the factory closure as Arg7 type.
    /// :param: arg8        An argument to the factory closure as Arg8 type.
    /// :param: arg9        An argument to the factory closure as Arg9 type.
    /// :param: arg10        An argument to the factory closure as Arg10 type.
    /// :param: arg11        An argument to the factory closure as Arg11 type.
    /// :param: arg12        An argument to the factory closure as Arg12 type.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type
    ///           and 12 arguments is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11, Arg12>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8, arg9: Arg9, arg10: Arg10, arg11: Arg11, arg12: Arg12) -> Service?
    {
        return resolve(serviceType, arg1: arg1, arg2: arg2, arg3: arg3, arg4: arg4, arg5: arg5, arg6: arg6, arg7: arg7, arg8: arg8, arg9: arg9, arg10: arg10, arg11: arg11, arg12: arg12, name: nil)
    }

    /// Retrieves the instance with the specified service type, 12 arguments to the factory closure and registration name.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    /// :param: arg5        An argument to the factory closure as Arg5 type.
    /// :param: arg6        An argument to the factory closure as Arg6 type.
    /// :param: arg7        An argument to the factory closure as Arg7 type.
    /// :param: arg8        An argument to the factory closure as Arg8 type.
    /// :param: arg9        An argument to the factory closure as Arg9 type.
    /// :param: arg10        An argument to the factory closure as Arg10 type.
    /// :param: arg11        An argument to the factory closure as Arg11 type.
    /// :param: arg12        An argument to the factory closure as Arg12 type.
    /// :param: name        The registration name.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type,
    ///           12 arguments and name is found in the `Container`.
    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11, Arg12>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8, arg9: Arg9, arg10: Arg10, arg11: Arg11, arg12: Arg12,
        name: String?) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11, Arg12) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12) }
    }

}
