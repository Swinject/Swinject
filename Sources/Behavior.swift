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
    /// one of the `register()` methods
    ///
    /// - Parameters:
    ///     - container: container into which an `entry` has been registered
    ///     - entry: ServiceEntry registered to the `container`
    ///     - name: name under which the service has been registered to the `container`
    func container<Service>(
        _ container: Container,
        didRegisterService entry: ServiceEntry<Service>,
        withName name: String?
    )
}
