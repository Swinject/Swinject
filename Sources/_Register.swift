//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

/// This protocol is designed for the use to extend Swinject functionality.
/// Do NOT use this protocol unless you intend to write an extension or plugin to Swinject framework.
///
/// A type conforming Register protocol must conform _Register protocol too.
public protocol _Register {
    /// This method is designed for the use to extend Swinject functionality.
    /// Do NOT use this method unless you intend to write an extension or plugin to Swinject framework.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to register.
    ///   - factory:     The closure to specify how the service type is resolved with the dependencies of the type.
    ///                  It is invoked when the ``Container`` needs to instantiate the instance.
    ///                  It takes a ``Resolver`` to inject dependencies to the instance,
    ///                  and returns the instance of the component type for the service.
    ///   - name:        A registration name.
    ///   - option:      A service key option for an extension/plugin.
    ///
    /// - Returns: A registered ``ServiceEntry`` to configure more settings with method chaining.
    @discardableResult
    // swiftlint:disable:next identifier_name
    func _register<Service, Arguments>(
        _ serviceType: Service.Type,
        factory: @escaping (Arguments) -> Any,
        name: String?,
        option: ServiceKeyOption?
    ) -> ServiceEntry<Service>
}
