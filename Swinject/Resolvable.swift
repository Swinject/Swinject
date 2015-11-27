//
//  Resolvable.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 8/18/15.
//  Copyright (c) 2015 Swinject Contributors. All rights reserved.
//

//
// NOTICE:
//
// Resolvable.swift is generated from Resolvable.erb by ERB.
// Do NOT modify Container.Arguments.swift directly.
// Instead, modify Resolvable.erb and run `script/gencode` at the project root directory to generate the code.
//


public protocol Resolvable {
    /// Retrieves the instance with the specified service type.
    ///
    /// - Parameter serviceType: The service type to resolve.
    ///
    /// - Returns: The resolved service type instance, or nil if no service is found.
    func resolve<Service>(serviceType: Service.Type) -> Service?

    /// Retrieves the instance with the specified service type and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///
    /// - Returns: The resolved service type instance, or nil if no service with the name is found.
    func resolve<Service>(serviceType: Service.Type, name: String?) -> Service?

    /// Retrieves the instance with the specified service type and 1 argument to the factory closure.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - argument:   1 argument to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and 1 argument is found.
    func resolve<Service, Arg1>(
        serviceType: Service.Type,
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
        serviceType: Service.Type,
        name: String?,
        argument: Arg1) -> Service?

    /// Retrieves the instance with the specified service type and tuple of 2 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - arguments:   Tuple of 2 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and tuple of 2 arguments is found.
    func resolve<Service, Arg1, Arg2>(
        serviceType: Service.Type,
        arguments: (Arg1, Arg2)) -> Service?

    /// Retrieves the instance with the specified service type, tuple of 2 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   Tuple of 2 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            tuple of 2 arguments and name is found.
    func resolve<Service, Arg1, Arg2>(
        serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2)) -> Service?

    /// Retrieves the instance with the specified service type and tuple of 3 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - arguments:   Tuple of 3 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and tuple of 3 arguments is found.
    func resolve<Service, Arg1, Arg2, Arg3>(
        serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3)) -> Service?

    /// Retrieves the instance with the specified service type, tuple of 3 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   Tuple of 3 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            tuple of 3 arguments and name is found.
    func resolve<Service, Arg1, Arg2, Arg3>(
        serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3)) -> Service?

    /// Retrieves the instance with the specified service type and tuple of 4 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - arguments:   Tuple of 4 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and tuple of 4 arguments is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4>(
        serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3, Arg4)) -> Service?

    /// Retrieves the instance with the specified service type, tuple of 4 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   Tuple of 4 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            tuple of 4 arguments and name is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4>(
        serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3, Arg4)) -> Service?

    /// Retrieves the instance with the specified service type and tuple of 5 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - arguments:   Tuple of 5 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and tuple of 5 arguments is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(
        serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5)) -> Service?

    /// Retrieves the instance with the specified service type, tuple of 5 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   Tuple of 5 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            tuple of 5 arguments and name is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(
        serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5)) -> Service?

    /// Retrieves the instance with the specified service type and tuple of 6 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - arguments:   Tuple of 6 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and tuple of 6 arguments is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(
        serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6)) -> Service?

    /// Retrieves the instance with the specified service type, tuple of 6 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   Tuple of 6 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            tuple of 6 arguments and name is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(
        serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6)) -> Service?

    /// Retrieves the instance with the specified service type and tuple of 7 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - arguments:   Tuple of 7 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and tuple of 7 arguments is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(
        serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7)) -> Service?

    /// Retrieves the instance with the specified service type, tuple of 7 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   Tuple of 7 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            tuple of 7 arguments and name is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(
        serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7)) -> Service?

    /// Retrieves the instance with the specified service type and tuple of 8 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - arguments:   Tuple of 8 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and tuple of 8 arguments is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(
        serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8)) -> Service?

    /// Retrieves the instance with the specified service type, tuple of 8 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   Tuple of 8 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            tuple of 8 arguments and name is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(
        serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8)) -> Service?

    /// Retrieves the instance with the specified service type and tuple of 9 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - arguments:   Tuple of 9 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and tuple of 9 arguments is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(
        serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9)) -> Service?

    /// Retrieves the instance with the specified service type, tuple of 9 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   Tuple of 9 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            tuple of 9 arguments and name is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(
        serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9)) -> Service?

    /// Retrieves the instance with the specified service type and tuple of 10 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - arguments:   Tuple of 10 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and tuple of 10 arguments is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10>(
        serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10)) -> Service?

    /// Retrieves the instance with the specified service type, tuple of 10 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   Tuple of 10 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            tuple of 10 arguments and name is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10>(
        serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10)) -> Service?

    /// Retrieves the instance with the specified service type and tuple of 11 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - arguments:   Tuple of 11 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and tuple of 11 arguments is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11>(
        serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11)) -> Service?

    /// Retrieves the instance with the specified service type, tuple of 11 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   Tuple of 11 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            tuple of 11 arguments and name is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11>(
        serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11)) -> Service?

    /// Retrieves the instance with the specified service type and tuple of 12 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - arguments:   Tuple of 12 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and tuple of 12 arguments is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11, Arg12>(
        serviceType: Service.Type,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11, Arg12)) -> Service?

    /// Retrieves the instance with the specified service type, tuple of 12 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name:        The registration name.
    ///   - arguments:   Tuple of 12 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            tuple of 12 arguments and name is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11, Arg12>(
        serviceType: Service.Type,
        name: String?,
        arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11, Arg12)) -> Service?

}
