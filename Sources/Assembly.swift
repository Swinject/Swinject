//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

/// The ``Assembly`` provides a means to organize your `Service` registration in logic groups which allows
/// the user to swap out different implementations of `Services` by providing different ``Assembly`` instances
/// to the ``Assembler``
public protocol Assembly {
    /// Provide hook for ``Assembler`` to load Services into the provided container
    ///
    /// - parameter container: the container provided by the ``Assembler``
    ///
    func assemble(container: Container)

    /// Provides a hook to the ``Assembly`` that will be called once the ``Assembler`` has loaded all ``Assembly``
    /// instances into the container.
    ///
    /// - parameter resolver: the resolver that can resolve instances from the built container
    ///
    func loaded(resolver: Resolver)
}

public extension Assembly {
    func loaded(resolver _: Resolver) {
        // no-op
    }
}

/// A ``SmartAssembly`` is an ``Assembly`` that can declare explicit dependencies
/// on other assemblies.
///
/// Unlike ``Assembly``, which relies on the user to manually provide all
/// required assemblies to an ``Assembler``, a ``SmartAssembly`` declares its
/// dependencies via `requiredAssemblies`.
///
/// These dependencies are used by ``SmartAssembler`` to:
/// - Automatically initialize and add missing required assemblies
///   (when `initializeMissingAssemblies` is enabled).
/// - Validate that all required assemblies are present before assembly.
/// - Detect and report circular dependencies between assemblies.
///
/// This enables safer and more maintainable assembly graphs by making
/// dependencies explicit and verifiable at runtime.
///
/// ## Example
/// ```swift
/// final class NetworkingAssembly: SmartAssembly {
///     static var requiredAssemblies: [SmartAssembly.Type] {
///         [CoreAssembly.self]
///     }
///
///     func assemble(container: Container) {
///         // register networking services
///     }
/// }
/// ```
///
/// When used with ``SmartAssembler``, `CoreAssembly` will be automatically
/// instantiated and assembled before `NetworkingAssembly`.
public protocol SmartAssembly: Assembly {

    /// The list of assemblies that must be present for this assembly to function
    /// correctly.
    ///
    /// Dependencies are evaluated recursively by ``SmartAssembler``, meaning
    /// required assemblies may themselves declare additional dependencies.
    ///
    /// The order of this array does not affect assembly order; dependency
    /// resolution is handled automatically.
    static var requiredAssemblies: [Assembly.Type] { get }

    /// Creates a new instance of the assembly.
    ///
    /// This initializer is required so that ``SmartAssembler`` can automatically
    /// instantiate missing required assemblies during validation.
    init()
}

public extension SmartAssembly {
    /// Default implementation indicating that the assembly has no dependencies.
    static var requiredAssemblies: [Assembly.Type] { [] }
}
