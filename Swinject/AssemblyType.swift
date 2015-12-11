//
//  AssemblyType.swift
//  Swinject
//
//  Created by mike.owens on 12/9/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//


/// The `AssemblyType` provides a means to organize your `Service` registration in logic groups which allows
/// the user to swap out different implementations of `Services` by providing different `AssemblyType` instances
/// to the `Assembler`
public protocol AssemblyType {
    
    /// Provide hook for `Assembler` to load Services into the provided container
    ///
    /// - parameter container: the container provided by the `Assembler`
    ///
    func assemble(container: Container)
    
    /// Provides a hook to the `AssemblyType` that will be called once the `Assembler` has loaded all `AssemblyType`
    /// instances into the container.
    ///
    /// - parameter resolver: the resolver that can resolve instances from the built container
    ///
    func loaded(resolver: ResolverType)
}

public extension AssemblyType {
    func loaded(resolver: ResolverType) {
        // no-op
    }
}
