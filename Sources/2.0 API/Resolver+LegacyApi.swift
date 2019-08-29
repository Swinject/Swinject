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
        return try? resolve(request(type: serviceType, tag: name, arg: Arguments())) as Service
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
        return try? resolve(request(type: serviceType, tag: name, arg: Arguments(argument))) as Service
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
        return try? resolve(request(type: serviceType, tag: name, arg: Arguments(arg1, arg2))) as Service
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
        return try? resolve(request(type: serviceType, tag: name, arg: Arguments(arg1, arg2, arg3))) as Service
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
        return try? resolve(request(type: serviceType, tag: name, arg: Arguments(arg1, arg2, arg3, arg4))) as Service
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
        return try? resolve(request(type: serviceType, tag: name, arg: Arguments(arg1, arg2, arg3, arg4, arg5))) as Service
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
        return try? resolve(request(type: serviceType, tag: name, arg: Arguments(arg1, arg2, arg3, arg4, arg5, arg6))) as Service
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
        return try? resolve(request(type: serviceType, tag: name, arg: Arguments(arg1, arg2, arg3, arg4, arg5, arg6, arg7))) as Service
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
        return try? resolve(request(type: serviceType, tag: name, arg: Arguments(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8))) as Service
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
        return try? resolve(request(type: serviceType, tag: name, arg: Arguments(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9))) as Service
    }
}

// sourcery:end
