//
//  Assembler.swift
//  Swinject
//
//  Created by mike.owens on 12/9/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//


/// The `Assembler` provides a means to build a container via `AssemblyType` instances.
public class Assembler {
    
    /// the container that each assembly will build its `Service` definitions into
    private let container: Container
    
    /// expose the container as a resolver so `Service` registration only happens within an assembly
    public var resolver: ResolverType {
        return container
    }
    
    /// Will create an empty `Assembler`
    ///
    /// - parameter container: the baseline container
    ///
    public init(container: Container? = Container()) {
        self.container = container!
    }
    
    /// Will create a new `Assembler` with the given `AssemblyType` instances to build a `Container`
    ///
    /// - parameter assemblies:         the list of assemblies to build the container from
    /// - parameter propertyLoaders:    a list of property loaders to apply to the container
    /// - parameter container:          the baseline container
    ///
    public init(assemblies: [AssemblyType], propertyLoaders: [PropertyLoaderType]? = nil, container: Container? = Container()) throws {
        self.container = container!
        if let propertyLoaders = propertyLoaders {
            for propertyLoader in propertyLoaders {
                try self.container.applyPropertyLoader(propertyLoader)
            }
        }
        runAssemblies(assemblies)
    }
    
    /// Will apply the assembly to the container. This is useful if you want to lazy load an assembly into the assembler's
    /// container.
    ///
    /// If this assembly type is load aware, the loaded hook will be invoked right after the container has assembled
    /// since after each call to `addAssembly` the container is fully loaded in its current state. If you wish to
    /// lazy load several assemblies that have interdependencies between each other use `appyAssemblies`
    ///
    /// - parameter assembly: the assembly to apply to the container
    ///
    public func applyAssembly(assembly: AssemblyType) {
        runAssemblies([assembly])
    }
    
    /// Will apply the assemblies to the container. This is useful if you want to lazy load several assemblies into the assembler's
    /// container
    ///
    /// If this assembly type is load aware, the loaded hook will be invoked right after the container has assembled
    /// since after each call to `addAssembly` the container is fully loaded in its current state.
    ///
    /// - parameter assemblies: the assemblies to apply to the container
    ///
    public func applyAssemblies(assemblies: [AssemblyType]) {
        runAssemblies(assemblies)
    }
    
    /// Will apply a property loader to the container. This is useful if you want to lazy load your assemblies or build
    /// your assembler manually
    ///
    /// - parameter propertyLoader: the property loader to apply to the assembler's container
    ///
    /// - throws: PropertyLoaderError
    ///
    public func applyPropertyLoader(propertyLoader: PropertyLoaderType) throws {
        try self.container.applyPropertyLoader(propertyLoader)
    }
    
    // MARK: Private
    
    private func runAssemblies(assemblies: [AssemblyType]) {
        // build the container from each assembly
        for assembly in assemblies {
            assembly.assemble(self.container)
        }
        
        // inform all of the assemblies that the container is loaded
        for assembly in assemblies {
            assembly.loaded(self.resolver)
        }
    }
}
