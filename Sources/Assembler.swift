//
//  Assembler.swift
//  Swinject
//
//  Created by mike.owens on 12/9/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

/// The `Assembler` provides a means to build a container via `Assembly` instances.
public final class Assembler {

    /// the container that each assembly will build its `Service` definitions into
    private let container: Container

    /// expose the container as a resolver so `Service` registration only happens within an assembly
    public var resolver: Resolver {
        return container
    }

    /// Will create an empty `Assembler`
    ///
    /// - parameter container: the baseline container
    ///
    public init(container: Container? = Container()) {
        self.container = container!
    }

    /// Will create an empty `Assembler`
    ///
    /// - parameter parentAssembler: the baseline assembler
    ///
    public init(parentAssembler: Assembler?) {
        container = Container(parent: parentAssembler?.container)
    }

    /// Will create a new `Assembler` with the given `Assembly` instances to build a `Container`
    ///
    /// - parameter assemblies:         the list of assemblies to build the container from
    /// - parameter container:          the baseline container
    ///
    @available(*, deprecated, message: "Use not throwing alternative: init(_:, container:)")
    public convenience init(assemblies: [Assembly], container: Container? = Container()) throws {
        if let container = container {
            self.init(assemblies, container: container)
        } else {
            self.init(assemblies)
        }
    }

    /// Will create a new `Assembler` with the given `Assembly` instances to build a `Container`
    ///
    /// - parameter assemblies:         the list of assemblies to build the container from
    /// - parameter container:          the baseline container
    ///
    public init(_ assemblies: [Assembly], container: Container = Container()) {
        self.container = container
        run(assemblies: assemblies)
    }

    /// Will create a new `Assembler` with the given `Assembly` instances to build a `Container`
    ///
    /// - parameter assemblies:         the list of assemblies to build the container from
    /// - parameter parentAssembler:    the baseline assembler
    ///
    @available(*, deprecated, message: "Use not throwing alternative: init(_:, parent:)")
    public convenience init(assemblies: [Assembly], parentAssembler: Assembler?) throws {
        self.init(_: assemblies, parent: parentAssembler)
    }

    /// Will create a new `Assembler` with the given `Assembly` instances to build a `Container`
    ///
    /// - parameter assemblies: the list of assemblies to build the container from
    /// - parameter parent:     the baseline assembler
    ///
    public init(_ assemblies: [Assembly], parent: Assembler?) {
        container = Container(parent: parent?.container)
        run(assemblies: assemblies)
    }

    /// Will apply the assembly to the container. This is useful if you want to lazy load an assembly into the 
    /// assembler's container.
    ///
    /// If this assembly type is load aware, the loaded hook will be invoked right after the container has assembled
    /// since after each call to `addAssembly` the container is fully loaded in its current state. If you wish to
    /// lazy load several assemblies that have interdependencies between each other use `appyAssemblies`
    ///
    /// - parameter assembly: the assembly to apply to the container
    ///
    public func apply(assembly: Assembly) {
        run(assemblies: [assembly])
    }

    /// Will apply the assemblies to the container. This is useful if you want to lazy load several assemblies into the 
    /// assembler's container
    ///
    /// If this assembly type is load aware, the loaded hook will be invoked right after the container has assembled
    /// since after each call to `addAssembly` the container is fully loaded in its current state.
    ///
    /// - parameter assemblies: the assemblies to apply to the container
    ///
    public func apply(assemblies: [Assembly]) {
        run(assemblies: assemblies)
    }

    // MARK: Private

    private func run(assemblies: [Assembly]) {
        // build the container from each assembly
        for assembly in assemblies {
            assembly.assemble(container: self.container)
        }

        // inform all of the assemblies that the container is loaded
        for assembly in assemblies {
            assembly.loaded(resolver: self.resolver)
        }
    }
}
