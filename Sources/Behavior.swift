//
//  Behavior.swift
//  Swinject-iOS
//
//  Created by Jakub Vaňo on 16/02/2018.
//  Copyright © 2018 Swinject Contributors. All rights reserved.
//

/// Protocol for adding functionality to the container
public protocol Behavior {
    /// This will be invoked on each behavior added to the `container` for each `entry` added to the container using
    /// one of the `register()` or type forwading methods
    ///
    /// - Parameters:
    ///     - container: container into which an `entry` has been registered
    ///     - type: Type which will be resolved using the `entry`
    ///     - entry: ServiceEntry registered to the `container`
    ///     - name: name under which the service has been registered to the `container`
    ///
    /// - Remark: `Type` and `Service` can be different types in the case of type forwarding
    func container<Type, Service>(
        _ container: Container,
        didRegisterType type: Type.Type,
        toService entry: ServiceEntry<Service>,
        withName name: String?
    )
}
