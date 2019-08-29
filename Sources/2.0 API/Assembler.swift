//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
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
    /// - parameter parent:             the baseline assembler
    /// - parameter defaultObjectScope: default object scope for container
    /// - parameter behaviors:          list of behaviors to be added to the container
    public convenience init(
        _ assemblies: [Assembly] = [],
        parent: Assembler? = nil,
        defaultObjectScope: ObjectScope = .graph,
        behaviors: [Behavior] = []
    ) {
        self.init(
            assemblies,
            parent: parent,
            defaultScope: defaultObjectScope.scope,
            defaultMakeRef: defaultObjectScope.makeRef,
            behaviors: behaviors
        )
    }

    /// Will create a new `Assembler` with the given `Assembly` instances to build a `Container`
    ///
    /// - parameter assemblies:         the list of assemblies to build the container from
    /// - parameter parent:             the baseline assembler
    /// - parameter defaultScope:       default  scope for container
    /// - parameter defaultMakeRef:     default  reference maker for container (`strongRef` by default)
    /// - parameter behaviors:          list of behaviors to be added to the container
    public init(
        _ assemblies: [Assembly] = [],
        parent: Assembler? = nil,
        defaultScope: AnyScope?,
        defaultMakeRef: @escaping ReferenceMaker<Any> = strongRef,
        behaviors: [Behavior] = []
    ) {
        container = Container(
            parent: parent?.container,
            defaultScope: defaultScope,
            defaultMakeRef: defaultMakeRef,
            behaviors: behaviors
        )
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
            assembly.assemble(container: container)
        }

        // inform all of the assemblies that the container is loaded
        for assembly in assemblies {
            assembly.loaded(resolver: resolver)
        }
    }
}
