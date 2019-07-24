//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// sourcery:inline:ResolverLegacyApi
public extension Resolver {
    /// Retrieves the instance with the specified service type and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///
    /// - Returns: The resolved service type instance, or nil if no service with the name is found.
    func resolve<Service>(_ serviceType: Service.Type, name: String? = nil) -> Service? {
        if let name = name {
            return try? resolve(request(type: serviceType, tag: name, arg: ()))
        } else {
            return try? resolve(request(type: serviceType, tag: NoTag(), arg: ()))
        }
    }

    /// Retrieves the instance with the specified service type, 1 argument to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - argument:   1 Argument to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            1 argument and name is found.
    func resolve<Service, Arg1>(_ serviceType: Service.Type, name: String? = nil, argument: Arg1) -> Service? {
        if let name = name {
            return try? resolve(request(type: serviceType, tag: name, arg: ()))
        } else {
            return try? resolve(request(type: serviceType, tag: NoTag(), arg: argument))
        }
    }

    /// Retrieves the instance with the specified service type, list of 2 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   List Of 2 Arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            list of 2 arguments and name is found.
    func resolve<Service, Arg1, Arg2>(_ serviceType: Service.Type, name: String? = nil, arguments arg1: Arg1, _ arg2: Arg2) -> Service? {
        if let name = name {
            return try? resolve(request(type: serviceType, tag: name, arg: ()))
        } else {
            return try? resolve(request(type: serviceType, tag: NoTag(), arg: (arg1, arg2)))
        }
    }

    /// Retrieves the instance with the specified service type, list of 3 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   List Of 3 Arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            list of 3 arguments and name is found.
    func resolve<Service, Arg1, Arg2, Arg3>(_ serviceType: Service.Type, name: String? = nil, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> Service? {
        if let name = name {
            return try? resolve(request(type: serviceType, tag: name, arg: ()))
        } else {
            return try? resolve(request(type: serviceType, tag: NoTag(), arg: (arg1, arg2, arg3)))
        }
    }

    /// Retrieves the instance with the specified service type, list of 4 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   List Of 4 Arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            list of 4 arguments and name is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4>(_ serviceType: Service.Type, name: String? = nil, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) -> Service? {
        if let name = name {
            return try? resolve(request(type: serviceType, tag: name, arg: ()))
        } else {
            return try? resolve(request(type: serviceType, tag: NoTag(), arg: (arg1, arg2, arg3, arg4)))
        }
    }

    /// Retrieves the instance with the specified service type, list of 5 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   List Of 5 Arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            list of 5 arguments and name is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(_ serviceType: Service.Type, name: String? = nil, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5) -> Service? {
        if let name = name {
            return try? resolve(request(type: serviceType, tag: name, arg: ()))
        } else {
            return try? resolve(request(type: serviceType, tag: NoTag(), arg: (arg1, arg2, arg3, arg4, arg5)))
        }
    }

    /// Retrieves the instance with the specified service type, list of 6 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   List Of 6 Arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            list of 6 arguments and name is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(_ serviceType: Service.Type, name: String? = nil, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6) -> Service? {
        if let name = name {
            return try? resolve(request(type: serviceType, tag: name, arg: ()))
        } else {
            return try? resolve(request(type: serviceType, tag: NoTag(), arg: (arg1, arg2, arg3, arg4, arg5, arg6)))
        }
    }

    /// Retrieves the instance with the specified service type, list of 7 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   List Of 7 Arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            list of 7 arguments and name is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(_ serviceType: Service.Type, name: String? = nil, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7) -> Service? {
        if let name = name {
            return try? resolve(request(type: serviceType, tag: name, arg: ()))
        } else {
            return try? resolve(request(type: serviceType, tag: NoTag(), arg: (arg1, arg2, arg3, arg4, arg5, arg6, arg7)))
        }
    }

    /// Retrieves the instance with the specified service type, list of 8 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   List Of 8 Arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            list of 8 arguments and name is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(_ serviceType: Service.Type, name: String? = nil, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7, _ arg8: Arg8) -> Service? {
        if let name = name {
            return try? resolve(request(type: serviceType, tag: name, arg: ()))
        } else {
            return try? resolve(request(type: serviceType, tag: NoTag(), arg: (arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)))
        }
    }

    /// Retrieves the instance with the specified service type, list of 9 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   List Of 9 Arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            list of 9 arguments and name is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(_ serviceType: Service.Type, name: String? = nil, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7, _ arg8: Arg8, _ arg9: Arg9) -> Service? {
        if let name = name {
            return try? resolve(request(type: serviceType, tag: name, arg: ()))
        } else {
            return try? resolve(request(type: serviceType, tag: NoTag(), arg: (arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)))
        }
    }
}

// sourcery:end
