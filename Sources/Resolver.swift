//
//  Resolver.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 8/18/15.
//  Copyright (c) 2015 Swinject Contributors. All rights reserved.
//

//
// NOTICE:
//
// Resolver.swift is generated from Resolver.erb by ERB.
// Do NOT modify Resolver.swift directly.
// Instead, modify Resolver.erb and run `script/gencode` at the project root directory to generate the code.
//


public protocol Resolver {
    /// Retrieves the instance with the specified service type.
    ///
    /// - Parameter serviceType: The service type to resolve.
    ///
    /// - Returns: The resolved service type instance, or nil if no service is found.
    func resolve<Service>(_ serviceType: Service.Type) -> Service?

    /// Retrieves the instance with the specified service type and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///
    /// - Returns: The resolved service type instance, or nil if no service with the name is found.
    func resolve<Service>(_ serviceType: Service.Type, name: String?) -> Service?

    /// Retrieves the instance with the specified service type and 1 argument to the factory closure.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - argument:   1 argument to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and 1 argument is found.
    func resolve<Service, Arg1>(
        _ serviceType: Service.Type,
        argument: Arg1) -> Service?

    /// Retrieves the instance with the specified service type, 1 argument to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - argument:   1 argument to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            1 argument and name is found.
    func resolve<Service, Arg1>(
        _ serviceType: Service.Type,
        name: String?,
        argument: Arg1) -> Service?

    /// Retrieves the instance with the specified service type and list of 2 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - arguments:   List of 2 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and list of 2 arguments is found.
    func resolve<Service, Arg1, Arg2>(
        _ serviceType: Service.Type,
        arguments arg1: Arg1, _ arg2: Arg2) -> Service?

    /// Retrieves the instance with the specified service type, list of 2 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   List of 2 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            list of 2 arguments and name is found.
    func resolve<Service, Arg1, Arg2>(
        _ serviceType: Service.Type,
        name: String?,
        arguments arg1: Arg1, _ arg2: Arg2) -> Service?

    /// Retrieves the instance with the specified service type and list of 3 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - arguments:   List of 3 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and list of 3 arguments is found.
    func resolve<Service, Arg1, Arg2, Arg3>(
        _ serviceType: Service.Type,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> Service?

    /// Retrieves the instance with the specified service type, list of 3 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   List of 3 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            list of 3 arguments and name is found.
    func resolve<Service, Arg1, Arg2, Arg3>(
        _ serviceType: Service.Type,
        name: String?,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> Service?

    /// Retrieves the instance with the specified service type and list of 4 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - arguments:   List of 4 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and list of 4 arguments is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4>(
        _ serviceType: Service.Type,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) -> Service?

    /// Retrieves the instance with the specified service type, list of 4 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   List of 4 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            list of 4 arguments and name is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4>(
        _ serviceType: Service.Type,
        name: String?,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) -> Service?

    /// Retrieves the instance with the specified service type and list of 5 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - arguments:   List of 5 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and list of 5 arguments is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(
        _ serviceType: Service.Type,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5) -> Service?

    /// Retrieves the instance with the specified service type, list of 5 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   List of 5 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            list of 5 arguments and name is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(
        _ serviceType: Service.Type,
        name: String?,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5) -> Service?

    /// Retrieves the instance with the specified service type and list of 6 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - arguments:   List of 6 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and list of 6 arguments is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(
        _ serviceType: Service.Type,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6) -> Service?

    /// Retrieves the instance with the specified service type, list of 6 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   List of 6 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            list of 6 arguments and name is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(
        _ serviceType: Service.Type,
        name: String?,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6) -> Service?

    /// Retrieves the instance with the specified service type and list of 7 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - arguments:   List of 7 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and list of 7 arguments is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(
        _ serviceType: Service.Type,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7) -> Service?

    /// Retrieves the instance with the specified service type, list of 7 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   List of 7 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            list of 7 arguments and name is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(
        _ serviceType: Service.Type,
        name: String?,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7) -> Service?

    /// Retrieves the instance with the specified service type and list of 8 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - arguments:   List of 8 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and list of 8 arguments is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(
        _ serviceType: Service.Type,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7, _ arg8: Arg8) -> Service?

    /// Retrieves the instance with the specified service type, list of 8 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   List of 8 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            list of 8 arguments and name is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(
        _ serviceType: Service.Type,
        name: String?,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7, _ arg8: Arg8) -> Service?

    /// Retrieves the instance with the specified service type and list of 9 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - arguments:   List of 9 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and list of 9 arguments is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(
        _ serviceType: Service.Type,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7, _ arg8: Arg8, _ arg9: Arg9) -> Service?

    /// Retrieves the instance with the specified service type, list of 9 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   List of 9 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            list of 9 arguments and name is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(
        _ serviceType: Service.Type,
        name: String?,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7, _ arg8: Arg8, _ arg9: Arg9) -> Service?


}
