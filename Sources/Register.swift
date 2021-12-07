//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
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

    /// Utility method to prevent making name a required arg
    @discardableResult
    func register<Service>(
        _ serviceType: Service.Type,
        factory: @escaping (Resolver) -> Service
    ) -> ServiceEntry<Service>
}

public extension Register {
    @discardableResult
    func register<Service>(
        _ serviceType: Service.Type,
        factory: @escaping (Resolver) -> Service
    ) -> ServiceEntry<Service> {
        return register(serviceType, name: nil, factory: factory)
    }
}
