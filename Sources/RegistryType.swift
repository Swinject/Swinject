//
//  RegistryType.swift
//  Swinject-iOS
//
//  Created by matsuokah on 2017/08/17.
//  Copyright © 2017年 Swinject Contributors. All rights reserved.
//

import Foundation

/// The `RegistryType` protocol helps to realize specifying the desirable registration without String.
public protocol RegistryType {
    var name: String { get }
}

// MARK: - Container
public extension Container {
    /// Adds a registration for the specified service with the factory closure to specify how the service is
    /// resolved with dependencies.
    ///
    /// - Parameters:
    ///   - serviceType:  The service type to register.
    ///   - registryType: A registration type, which is used to differentiate from other registrations
    ///                   that have the same service and factory types.
    ///   - factory:      The closure to specify how the service type is resolved with the dependencies of the type.
    ///                   It is invoked when the `Container` needs to instantiate the instance.
    ///                   It takes a `Resolver` to inject dependencies to the instance,
    ///                   and returns the instance of the component type for the service.
    ///
    /// - Returns: A registered `ServiceEntry` to configure more settings with method chaining.
    @discardableResult
    public func register<Service>(
        _ serviceType: Service.Type,
        registryType: RegistryType,
        factory: @escaping (Resolver) -> Service
        ) -> ServiceEntry<Service> {
        return _register(serviceType, factory: factory, name: registryType.name)
    }
}
