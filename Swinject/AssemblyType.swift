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
}

/// The `AssemblyLoadAwareType` provies a means for the `Assembler` to inform the `AssemblyType` that the container
/// has been loaded. This hook is useful for when an `AssemblyType` needs to run some code after the
/// container has registered all `Services` from all `AssemblyType` instances passed to the `Assembler`. For
/// example, one might want to setup some 3rd party services or load some `Services` into a singleton
public protocol AssemblyLoadAwareType: AssemblyType {
    
    /// Provides a hook to the `AssemblyLoadAwareType` that will be called once the `Assembler` has loaded all `AssemblyType`
    /// instances into the container.
    ///
    /// - parameter resolver: the resolver that can resolve instances from the built container
    ///
    func loaded(resolver: ResolverType)
}
