//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// sourcery:inline:ContainerRegistrationApi
extension Container {
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
    public func register<Service>(_: Service.Type, name: String? = nil, factory: @escaping (Resolver) -> Service) -> ServiceEntry<Service> {
        let entry = ServiceEntry<Service>(container: self, name: name, scope: defaultScope, makeRef: defaultMakeRef, argumentDescriptor: []) { r, _ in factory(r) }
        addEntry(entry, with: name)
        return entry
    }

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
    public func register<Service, Arg1>(_: Service.Type, name: String? = nil, factory: @escaping (Resolver, Arg1) -> Service) -> ServiceEntry<Service> {
        let entry = ServiceEntry<Service>(container: self, name: name, scope: defaultScope, makeRef: defaultMakeRef, argumentDescriptor: [Arg1.self]) { r, a in try! factory(r, a.arg(0)) }
        addEntry(entry, with: name)
        return entry
    }

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
    public func register<Service, Arg1, Arg2>(_: Service.Type, name: String? = nil, factory: @escaping (Resolver, Arg1, Arg2) -> Service) -> ServiceEntry<Service> {
        let entry = ServiceEntry<Service>(container: self, name: name, scope: defaultScope, makeRef: defaultMakeRef, argumentDescriptor: [Arg1.self, Arg2.self]) { r, a in try! factory(r, a.arg(0), a.arg(1)) }
        addEntry(entry, with: name)
        return entry
    }

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
    public func register<Service, Arg1, Arg2, Arg3>(_: Service.Type, name: String? = nil, factory: @escaping (Resolver, Arg1, Arg2, Arg3) -> Service) -> ServiceEntry<Service> {
        let entry = ServiceEntry<Service>(container: self, name: name, scope: defaultScope, makeRef: defaultMakeRef, argumentDescriptor: [Arg1.self, Arg2.self, Arg3.self]) { r, a in try! factory(r, a.arg(0), a.arg(1), a.arg(2)) }
        addEntry(entry, with: name)
        return entry
    }

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
    public func register<Service, Arg1, Arg2, Arg3, Arg4>(_: Service.Type, name: String? = nil, factory: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4) -> Service) -> ServiceEntry<Service> {
        let entry = ServiceEntry<Service>(container: self, name: name, scope: defaultScope, makeRef: defaultMakeRef, argumentDescriptor: [Arg1.self, Arg2.self, Arg3.self, Arg4.self]) { r, a in try! factory(r, a.arg(0), a.arg(1), a.arg(2), a.arg(3)) }
        addEntry(entry, with: name)
        return entry
    }

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
    public func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(_: Service.Type, name: String? = nil, factory: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4, Arg5) -> Service) -> ServiceEntry<Service> {
        let entry = ServiceEntry<Service>(container: self, name: name, scope: defaultScope, makeRef: defaultMakeRef, argumentDescriptor: [Arg1.self, Arg2.self, Arg3.self, Arg4.self, Arg5.self]) { r, a in try! factory(r, a.arg(0), a.arg(1), a.arg(2), a.arg(3), a.arg(4)) }
        addEntry(entry, with: name)
        return entry
    }

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
    public func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(_: Service.Type, name: String? = nil, factory: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6) -> Service) -> ServiceEntry<Service> {
        let entry = ServiceEntry<Service>(container: self, name: name, scope: defaultScope, makeRef: defaultMakeRef, argumentDescriptor: [Arg1.self, Arg2.self, Arg3.self, Arg4.self, Arg5.self, Arg6.self]) { r, a in try! factory(r, a.arg(0), a.arg(1), a.arg(2), a.arg(3), a.arg(4), a.arg(5)) }
        addEntry(entry, with: name)
        return entry
    }

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
    public func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(_: Service.Type, name: String? = nil, factory: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7) -> Service) -> ServiceEntry<Service> {
        let entry = ServiceEntry<Service>(container: self, name: name, scope: defaultScope, makeRef: defaultMakeRef, argumentDescriptor: [Arg1.self, Arg2.self, Arg3.self, Arg4.self, Arg5.self, Arg6.self, Arg7.self]) { r, a in try! factory(r, a.arg(0), a.arg(1), a.arg(2), a.arg(3), a.arg(4), a.arg(5), a.arg(6)) }
        addEntry(entry, with: name)
        return entry
    }

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
    public func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(_: Service.Type, name: String? = nil, factory: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8) -> Service) -> ServiceEntry<Service> {
        let entry = ServiceEntry<Service>(container: self, name: name, scope: defaultScope, makeRef: defaultMakeRef, argumentDescriptor: [Arg1.self, Arg2.self, Arg3.self, Arg4.self, Arg5.self, Arg6.self, Arg7.self, Arg8.self]) { r, a in try! factory(r, a.arg(0), a.arg(1), a.arg(2), a.arg(3), a.arg(4), a.arg(5), a.arg(6), a.arg(7)) }
        addEntry(entry, with: name)
        return entry
    }

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
    public func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(_: Service.Type, name: String? = nil, factory: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9) -> Service) -> ServiceEntry<Service> {
        let entry = ServiceEntry<Service>(container: self, name: name, scope: defaultScope, makeRef: defaultMakeRef, argumentDescriptor: [Arg1.self, Arg2.self, Arg3.self, Arg4.self, Arg5.self, Arg6.self, Arg7.self, Arg8.self, Arg9.self]) { r, a in try! factory(r, a.arg(0), a.arg(1), a.arg(2), a.arg(3), a.arg(4), a.arg(5), a.arg(6), a.arg(7), a.arg(8)) }
        addEntry(entry, with: name)
        return entry
    }
}

// sourcery:end
