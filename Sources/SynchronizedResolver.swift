//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

internal final class SynchronizedResolver {
    internal let container: Container

    internal init(container: Container) {
        self.container = container
    }
}

extension SynchronizedResolver: _Resolver {
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

extension SynchronizedResolver: Resolver {
    
    var synchronizedResolver: Resolver { self }

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
