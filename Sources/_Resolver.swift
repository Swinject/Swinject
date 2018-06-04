//
//  _Resolver.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 5/4/16.
//  Copyright © 2016 Swinject Contributors. All rights reserved.
//

/// This protocol is designed for the use to extend Swinject functionality.
/// Do NOT use this protocol unless you intend to write an extension or plugin to Swinject framework.
///
/// A type conforming Resolver protocol must conform _Resolver protocol too.
public protocol _Resolver {
    /// This method is designed for the use to extend Swinject functionality.
    /// Do NOT use this method unless you intend to write an extension or plugin to Swinject framework.
    ///
    /// - Parameter name: The registration name.
    /// - Parameter option: A service key option for an extension/plugin.
    /// - Parameter invoker: A closure to execute service resolution.
    ///
    /// - Returns: The resolved service type instance, or nil if no service is found.
    // swiftlint:disable:next identifier_name
    func _resolve<Service, Arguments>(
        name: String?,
        option: ServiceKeyOption?,
        invoker: @escaping ((Arguments) -> Any) -> Any
    ) -> Service?
}
