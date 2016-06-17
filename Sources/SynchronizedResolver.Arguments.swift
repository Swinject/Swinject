//
//  SynchronizedResolver.Arguments.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 11/23/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

//
// NOTICE:
//
// SynchronizedResolver.Arguments.swift is generated from SynchronizedResolver.Arguments.erb by ERB.
// Do NOT modify SynchronizedResolver.Arguments.swift directly.
// Instead, modify SynchronizedResolver.Arguments.erb and run `script/gencode` at the project root directory to generate the code.
//


// MARK: - ResolverType with Arguments
extension SynchronizedResolver {
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
        arguments: (Arg1, Arg2)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2>(
        _ serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, name: name, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3>(
        _ serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3>(
        _ serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, name: name, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4>(
        _ serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3, Arg4)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4>(
        _ serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3, Arg4)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, name: name, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(
        _ serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(
        _ serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, name: name, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(
        _ serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(
        _ serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, name: name, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(
        _ serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(
        _ serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, name: name, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(
        _ serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(
        _ serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, name: name, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(
        _ serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(
        _ serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, name: name, arguments: arguments)
        }
    }

}
