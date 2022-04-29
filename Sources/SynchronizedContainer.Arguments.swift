//
//  SynchronizedContainer.Arguments.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 11/23/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

//
// NOTICE:
//
// SynchronizedContainer.Arguments.swift is generated from SynchronizedContainer.Arguments.erb by ERB.
// Do NOT modify SynchronizedContainer.Arguments.swift directly.
// Instead, modify SynchronizedContainer.Arguments.erb and run `script/gencode` at the project root directory to generate the code.
//


// MARK: - Register with Arguments
extension SynchronizedContainer {
    internal func register<Service, Arg1>(
        _ serviceType: Service.Type,
        name: String?,
        factory: @escaping (Resolver, Arg1) -> Service) -> ServiceEntry<Service>
    {
        return container.lock.sync {
            return self.container.register(serviceType, name: name, factory: factory)
        }
    }
    internal func register<Service, Arg1, Arg2>(
        _ serviceType: Service.Type,
        name: String?,
        factory: @escaping (Resolver, Arg1, Arg2) -> Service) -> ServiceEntry<Service>
    {
        return container.lock.sync {
            return self.container.register(serviceType, name: name, factory: factory)
        }
    }
    internal func register<Service, Arg1, Arg2, Arg3>(
        _ serviceType: Service.Type,
        name: String?,
        factory: @escaping (Resolver, Arg1, Arg2, Arg3) -> Service) -> ServiceEntry<Service>
    {
        return container.lock.sync {
            return self.container.register(serviceType, name: name, factory: factory)
        }
    }
    internal func register<Service, Arg1, Arg2, Arg3, Arg4>(
        _ serviceType: Service.Type,
        name: String?,
        factory: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4) -> Service) -> ServiceEntry<Service>
    {
        return container.lock.sync {
            return self.container.register(serviceType, name: name, factory: factory)
        }
    }
    internal func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(
        _ serviceType: Service.Type,
        name: String?,
        factory: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4, Arg5) -> Service) -> ServiceEntry<Service>
    {
        return container.lock.sync {
            return self.container.register(serviceType, name: name, factory: factory)
        }
    }
    internal func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(
        _ serviceType: Service.Type,
        name: String?,
        factory: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6) -> Service) -> ServiceEntry<Service>
    {
        return container.lock.sync {
            return self.container.register(serviceType, name: name, factory: factory)
        }
    }
    internal func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(
        _ serviceType: Service.Type,
        name: String?,
        factory: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7) -> Service) -> ServiceEntry<Service>
    {
        return container.lock.sync {
            return self.container.register(serviceType, name: name, factory: factory)
        }
    }
    internal func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(
        _ serviceType: Service.Type,
        name: String?,
        factory: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8) -> Service) -> ServiceEntry<Service>
    {
        return container.lock.sync {
            return self.container.register(serviceType, name: name, factory: factory)
        }
    }
    internal func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(
        _ serviceType: Service.Type,
        name: String?,
        factory: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9) -> Service) -> ServiceEntry<Service>
    {
        return container.lock.sync {
            return self.container.register(serviceType, name: name, factory: factory)
        }
    }
}

// MARK: - Resolver with Arguments
extension SynchronizedContainer {
    internal func resolve<Service, Arg1>(
        _ serviceType: Service.Type,
        argument: Arg1) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, argument: argument)
        }
    }

    internal func resolve<Service, Arg1>(
        _ serviceType: Service.Type,
        name: String?,
        argument: Arg1) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, name: name, argument: argument)
        }
    }

    internal func resolve<Service, Arg1, Arg2>(
        _ serviceType: Service.Type,
        arguments arg1: Arg1, _ arg2: Arg2) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, arguments: arg1, arg2)
        }
    }

    internal func resolve<Service, Arg1, Arg2>(
        _ serviceType: Service.Type,
        name: String?,
        arguments arg1: Arg1, _ arg2: Arg2) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, name: name, arguments: arg1, arg2)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3>(
        _ serviceType: Service.Type,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, arguments: arg1, arg2, arg3)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3>(
        _ serviceType: Service.Type,
        name: String?,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, name: name, arguments: arg1, arg2, arg3)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4>(
        _ serviceType: Service.Type,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, arguments: arg1, arg2, arg3, arg4)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4>(
        _ serviceType: Service.Type,
        name: String?,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, name: name, arguments: arg1, arg2, arg3, arg4)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(
        _ serviceType: Service.Type,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, arguments: arg1, arg2, arg3, arg4, arg5)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(
        _ serviceType: Service.Type,
        name: String?,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, name: name, arguments: arg1, arg2, arg3, arg4, arg5)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(
        _ serviceType: Service.Type,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, arguments: arg1, arg2, arg3, arg4, arg5, arg6)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(
        _ serviceType: Service.Type,
        name: String?,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, name: name, arguments: arg1, arg2, arg3, arg4, arg5, arg6)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(
        _ serviceType: Service.Type,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, arguments: arg1, arg2, arg3, arg4, arg5, arg6, arg7)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(
        _ serviceType: Service.Type,
        name: String?,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, name: name, arguments: arg1, arg2, arg3, arg4, arg5, arg6, arg7)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(
        _ serviceType: Service.Type,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7, _ arg8: Arg8) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, arguments: arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(
        _ serviceType: Service.Type,
        name: String?,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7, _ arg8: Arg8) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, name: name, arguments: arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(
        _ serviceType: Service.Type,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7, _ arg8: Arg8, _ arg9: Arg9) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, arguments: arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(
        _ serviceType: Service.Type,
        name: String?,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7, _ arg8: Arg8, _ arg9: Arg9) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, name: name, arguments: arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
        }
    }

}
