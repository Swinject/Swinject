//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

internal final class SynchronizedContainer {
    internal let container: Container

    internal init(container: Container) {
        self.container = container
    }
}

extension SynchronizedContainer: _Resolver {
    // swiftlint:disable:next identifier_name
    internal func _resolve<Service, Arguments>(
        name: String?,
        option: ServiceKeyOption?,
        invoker: @escaping ((Arguments) -> Any) -> Any
    ) -> Service? {
        return container.lock.sync {
            self.container._resolve(name: name, option: option, invoker: invoker)
        }
    }
}

extension SynchronizedContainer: Resolver {
    internal func resolve<Service>(_ serviceType: Service.Type) -> Service? {
        return container.lock.sync {
            self.container.resolve(serviceType)
        }
    }

    internal func resolve<Service>(_ serviceType: Service.Type, name: String?) -> Service? {
        return container.lock.sync {
            self.container.resolve(serviceType, name: name)
        }
    }
}

extension SynchronizedContainer: _Register {
    // swiftlint:disable:next identifier_name
    func _register<Service, Arguments>(_ serviceType: Service.Type,
                                       factory: @escaping (Arguments) -> Any,
                                       name: String?,
                                       option: ServiceKeyOption?) -> ServiceEntry<Service> {
        return container.lock.sync {
            self.container._register(serviceType, factory: factory, name: name, option: option)
        }
    }
}

extension SynchronizedContainer: Register {
    func register<Service>(_ serviceType: Service.Type,
                           name: String?,
                           factory: @escaping (Resolver) -> Service) -> ServiceEntry<Service> {
        return container.lock.sync {
            self.container.register(serviceType, name: name, factory: factory)
        }
    }
}
