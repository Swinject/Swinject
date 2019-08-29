//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

extension Container {
    /// Adds the registration for `type` which resolves in the same way, as would the type
    /// used to create the original `service` - i.e. using the same object scope,
    /// arguments and `initCompleted` closures.
    ///
    /// ** Example usage **
    ///
    ///     let service = container.register(Dog.self) { _ in Dog() }
    ///     container.forward(Animal.self, to: service)
    ///
    ///     let dogAsAnimal = container.resolve(Animal.self)
    ///
    /// - Parameters:
    ///     - type: Type resolution of which should be forwarded
    ///     - name: A registration name, which is used to differentiate from other registrations of the same `type`
    ///     - service: ServiceEntry which should be used for resolution of `type`
    public func forward<T, S>(_ type: T.Type, name: String? = nil, to service: ServiceEntry<S>) {
        addBinding(
            type: type,
            key: BindingKey(
                type: tagged(T.self, with: name),
                contextType: service.key.contextType,
                arguments: service.key.arguments
            ),
            name: name,
            entry: service
        )
    }
}
