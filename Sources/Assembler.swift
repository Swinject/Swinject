//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Foundation

/// The ``Assembler`` provides a means to build a container via ``Assembly`` instances.
public final class Assembler {
    /// Defines how the `Assembler` validates and applies assemblies.
    ///
    /// The assembler can operate in classic mode, which matches the original
    /// Swinject behavior, or in smart mode, which adds dependency-aware validation
    /// for assemblies that conform to `SmartAssembly`.
    public enum Mode {

        /// Classic assembly behavior.
        ///
        /// Assemblies are applied in the order they are added, with no validation
        /// of inter-assembly dependencies. This mode is fully backward compatible
        /// with the original `Assembler` implementation.
        case classic

        /// Dependency-aware assembly behavior.
        ///
        /// In this mode, assemblies that conform to `SmartAssembly` may declare
        /// required assemblies. These dependencies are validated before assembly
        /// occurs, and missing assemblies may be automatically instantiated
        /// depending on configuration.
        ///
        /// Assemblies that do not conform to `SmartAssembly` are unaffected and
        /// behave as they would in classic mode.
        ///
        /// - Parameter initializeMissingAssemblies:
        ///   If `true`, any required assemblies that are not present will be
        ///   automatically instantiated and added to the assembler.
        ///   If `false`, missing required assemblies will be reported as errors.
        case smart(initializeMissingAssemblies: Bool = true)
    }

    /// Errors that may occur during assembly.
    public enum Error: Swift.Error, Equatable {
        public static func == (lhs: Assembler.Error, rhs: Assembler.Error) -> Bool {
            switch (lhs, rhs) {
            case (.missingRequiredAssemblies(let left), .missingRequiredAssemblies(let right)),
                (.circularDependency(let left), .circularDependency(let right)):
                return left == right
            default:
                return false
            }
        }

        /// Thrown when one or more assemblies declare dependencies that are not present
        /// in the Assembler. The associated array contains the missing assembly type names.
        case missingRequiredAssemblies([String])

        /// Thrown when a circular dependency between assemblies is detected.
        ///
        /// The associated array contains the names of the assemblies forming the cycle,
        /// starting and ending with the same assembly to show the loop.
        case circularDependency([String])
    }

    /// the container that each assembly will build its ``Service`` definitions into
    private let container: Container

    /// Determines how the assembler validates and applies assemblies.
    ///
    /// The selected mode controls whether dependency validation is performed
    /// and whether missing required assemblies are automatically initialized.
    private let mode: Mode

    /// The assemblies that have been added to the assembler.
    ///
    /// These assemblies are applied to the container in the order they appear.
    /// In smart mode, this collection may be augmented with automatically
    /// initialized assemblies required by `SmartAssembly` dependencies.
    private var assemblies: [Assembly]

    /// expose the container as a resolver so ``Service`` registration only happens within an assembly
    public var resolver: Resolver {
        return container
    }

    /// Will create an empty ``Assembler``
    ///
    /// - parameter container: the baseline container
    ///
    public init(container: Container? = Container(), mode: Mode = .classic) {
        self.container = container!
        self.mode = mode
        self.assemblies = []
    }

    /// Will create an empty ``Assembler``
    ///
    /// - parameter parentAssembler: the baseline assembler
    /// - parameter defaultObjectScope: default object scope for container
    /// - parameter behaviors: list of behaviors to be added to the container
    public init(
        parentAssembler: Assembler?,
        defaultObjectScope: ObjectScope = .graph,
        behaviors: [Behavior] = [],
        mode: Mode = .classic
    ) {
        self.container = Container(
            parent: parentAssembler?.container,
            defaultObjectScope: defaultObjectScope,
            behaviors: behaviors
        )
        self.mode = mode
        self.assemblies = []
    }

    /// Will create a new ``Assembler`` with the given ``Assembly`` instances to build a ``Container``
    ///
    /// - parameter assemblies:         the list of assemblies to build the container from
    /// - parameter container:          the baseline container
    ///
    @available(*, deprecated, message: "Use not throwing alternative: init(_:, container:)")
    public convenience init(
        assemblies: [Assembly],
        container: Container? = Container(),
        mode: Mode = .classic
    ) throws {
        if let container = container {
            self.init(
                assemblies,
                container: container,
                mode: mode
            )
        } else {
            self.init(
                assemblies,
                mode: mode
            )
        }
    }

    /// Will create a new ``Assembler`` with the given ``Assembly`` instances to build a ``Container``
    ///
    /// - parameter assemblies:         the list of assemblies to build the container from
    /// - parameter container:          the baseline container
    ///
    public init(
        _ assemblies: [Assembly],
        container: Container = Container(),
        mode: Mode = .classic
    ) {
        self.container = container
        self.mode = mode
        self.assemblies = assemblies
        run(assemblies: assemblies)
    }

    /// Will create a new ``Assembler`` with the given ``Assembly`` instances to build a ``Container``
    ///
    /// - parameter assemblies:         the list of assemblies to build the container from
    /// - parameter parentAssembler:    the baseline assembler
    ///
    @available(*, deprecated, message: "Use not throwing alternative: init(_:, parent:)")
    public convenience init(
        assemblies: [Assembly],
        parentAssembler: Assembler?,
        mode: Mode = .classic
    ) throws {
        self.init(
            _: assemblies,
            parent: parentAssembler,
            mode: mode
        )
    }

    /// Will create a new ``Assembler`` with the given ``Assembly`` instances to build a ``Container``
    ///
    /// - parameter assemblies:         the list of assemblies to build the container from
    /// - parameter parent:             the baseline assembler
    /// - parameter defaultObjectScope: default object scope for container
    /// - parameter behaviors:          list of behaviors to be added to the container
    public init(
        _ assemblies: [Assembly],
        parent: Assembler?,
        defaultObjectScope: ObjectScope = .graph,
        behaviors: [Behavior] = [],
        mode: Mode = .classic
    ) {
        self.container = Container(
            parent: parent?.container,
            defaultObjectScope: defaultObjectScope,
            behaviors: behaviors
        )
        self.mode = mode
        self.assemblies = assemblies

        self.run(assemblies: assemblies)
    }

    /// Will apply the assembly to the container. This is useful if you want to lazy load an assembly into the
    /// assembler's container.
    ///
    /// If this assembly type is load aware, the loaded hook will be invoked right after the container has assembled
    /// since after each call to ``apply(assembly:)`` the container is fully loaded in its current state. If you wish to
    /// lazy load several assemblies that have interdependencies between each other use ``apply(assemblies:)``.
    ///
    /// - parameter assembly: the assembly to apply to the container
    ///
    public func apply(assembly: Assembly) {
        self.assemblies.append(assembly)
        run(assemblies: [assembly])
    }

    /// Will apply the assemblies to the container. This is useful if you want to lazy load several assemblies into the
    /// assembler's container
    ///
    /// If this assembly type is load aware, the loaded hook will be invoked right after the container has assembled
    /// since after each call to ``apply(assemblies:)`` the container is fully loaded in its current state.
    ///
    /// - parameter assemblies: the assemblies to apply to the container
    ///
    public func apply(assemblies: [Assembly]) {
        self.assemblies += assemblies
        run(assemblies: assemblies)
    }

    // MARK: Private

    private func run(assemblies: [Assembly]) {
        var allAssembliesToAssemble = assemblies

        // In smart mode, validate and get missing assemblies
        if case .smart(let initializeMissingAssemblies) = mode {
            do {
                let missingAssemblies = try validateAssemblies(initializeMissingAssemblies)
                // Add missing assemblies before the ones originally passed
                allAssembliesToAssemble = missingAssemblies + allAssembliesToAssemble
                // Update self.assemblies to include the new missing ones
                self.assemblies += missingAssemblies
            } catch {
                Self.log(String(describing: error))
            }
        }

        // Assemble everything in order
        for assembly in allAssembliesToAssemble {
            assembly.assemble(container: container)
        }

        // Notify all assemblies they are loaded
        for assembly in allAssembliesToAssemble {
            assembly.loaded(resolver: resolver)
        }
    }

    private func validateAssemblies(_ initializeMissingAssemblies: Bool) throws -> [SmartAssembly] {
        var presentIdentifiers = Set(self.assemblies.map { ObjectIdentifier(type(of: $0)) })
        var missingSmartAssemblies: [SmartAssembly.Type] = []
        var missingNonSmartAssemblies: [Assembly.Type] = []

        var visitingStack: [Assembly.Type] = []
        var visited = Set<ObjectIdentifier>()

        func visit(_ assemblyType: Assembly.Type) throws {
            if visitingStack.contains(where: { $0 == assemblyType }) {
                let cycle = visitingStack.map { String(describing: $0) } + [String(describing: assemblyType)]
                throw Assembler.Error.circularDependency(cycle)
            }

            let id = ObjectIdentifier(assemblyType)
            guard !visited.contains(id) else { return }
            visited.insert(id)
            visitingStack.append(assemblyType)

            if let smart = assemblyType as? SmartAssembly.Type {
                for dep in smart.requiredAssemblies {
                    try visit(dep)
                }
            }

            visitingStack.removeLast()

            if !presentIdentifiers.contains(id) {
                if let smart = assemblyType as? SmartAssembly.Type {
                    missingSmartAssemblies.append(smart)
                } else {
                    missingNonSmartAssemblies.append(assemblyType)
                }
                presentIdentifiers.insert(id)
            }
        }

        for assembly in assemblies {
            try visit(type(of: assembly))
        }

        if !initializeMissingAssemblies, (!missingSmartAssemblies.isEmpty || !missingNonSmartAssemblies.isEmpty) {
            let missingNames = (missingSmartAssemblies.map { String(describing: $0) } +
                                missingNonSmartAssemblies.map { String(describing: $0) }).sorted()
            throw Assembler.Error.missingRequiredAssemblies(missingNames)
        }

        // Log non-auto-initializable assemblies
        for assemblyType in missingNonSmartAssemblies {
            Self.log("Warning: Cannot auto-initialize non-SmartAssembly \(assemblyType). Please add it manually.")
        }

        // Instantiate missing SmartAssemblies
        return missingSmartAssemblies.map { $0.init() }
    }
}

extension Assembler {
    internal static func log(_ message: String) {
        if ProcessInfo.processInfo.environment["SWINJECT_LOGGING_ENABLED"] == "1" {
            print(message)
        }
    }
}
