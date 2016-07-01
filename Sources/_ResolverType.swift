//
//  _ResolverType.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 5/4/16.
//  Copyright © 2016 Swinject Contributors. All rights reserved.
//

/// This protocol is designed for the use to extend Swinject functionality.
/// Do NOT use this protocol unless you intend to write an extension or plugin to Swinject framework.
///
/// A type conforming ResolverType protocol must conform _ResolverType protocol too.
public protocol _ResolverType {
    /// This method is designed for the use to extend Swinject functionality.
    /// Do NOT use this method unless you intend to write an extension or plugin to Swinject framework.
    ///
    /// - Parameter name: The registration name.
    /// - Parameter option: A service key option for an extension/plugin.
    /// - Parameter invoker: A closure to execute service resolution.
    ///
    /// - Returns: The resolved service type instance, or nil if no service is found.
    func _resolve<Service, Factory>(name name: String?, option: ServiceKeyOptionType?, invoker: Factory -> Service) -> Service?
}
