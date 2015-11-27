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


// MARK: - Resolvable with Arguments
extension SynchronizedResolver {
    internal func resolve<Service, Arg1>(
        serviceType: Service.Type,
        argument: Arg1) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, argument: argument)
        }
    }

    internal func resolve<Service, Arg1>(
        serviceType: Service.Type,
        name: String?,
        argument: Arg1) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, name: name, argument: argument)
        }
    }

    internal func resolve<Service, Arg1, Arg2>(
        serviceType: Service.Type,
        arguments: (Arg1, Arg2)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2>(
        serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, name: name, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3>(
        serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3>(
        serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, name: name, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4>(
        serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3, Arg4)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4>(
        serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3, Arg4)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, name: name, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(
        serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(
        serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, name: name, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(
        serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(
        serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, name: name, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(
        serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(
        serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, name: name, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(
        serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(
        serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, name: name, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(
        serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(
        serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, name: name, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10>(
        serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10>(
        serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, name: name, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11>(
        serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11>(
        serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, name: name, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11, Arg12>(
        serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11, Arg12)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, arguments: arguments)
        }
    }

    internal func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11, Arg12>(
        serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11, Arg12)) -> Service?
    {
        return container.lock.sync {
            return self.container.resolve(serviceType, name: name, arguments: arguments)
        }
    }

}
