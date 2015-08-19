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
    /// :param: serviceType The service type to resolve.
    ///
    /// :returns: The resolved service type instance, or nil if no service is found.
    func resolve<Service>(serviceType: Service.Type) -> Service?

    /// Retrieves the instance with the specified service type and registration name.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: name        The registration name.
    ///
    /// :returns: The resolved service type instance, or nil if no service with the name is found.
    func resolve<Service>(serviceType: Service.Type, name: String?) -> Service?

    /// Retrieves the instance with the specified service type and 1 argument to the factory closure.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type
    ///           and 1 argument is found.
    func resolve<Service, Arg1>(
        serviceType: Service.Type,
        arg1: Arg1) -> Service?

    /// Retrieves the instance with the specified service type, 1 argument to the factory closure and registration name.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: name        The registration name.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type,
    ///           1 argument and name is found.
    func resolve<Service, Arg1>(
        serviceType: Service.Type,
        arg1: Arg1,
        name: String?) -> Service?

    /// Retrieves the instance with the specified service type and 2 arguments to the factory closure.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type
    ///           and 2 arguments is found.
    func resolve<Service, Arg1, Arg2>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2) -> Service?

    /// Retrieves the instance with the specified service type, 2 arguments to the factory closure and registration name.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: name        The registration name.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type,
    ///           2 arguments and name is found.
    func resolve<Service, Arg1, Arg2>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2,
        name: String?) -> Service?

    /// Retrieves the instance with the specified service type and 3 arguments to the factory closure.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type
    ///           and 3 arguments is found.
    func resolve<Service, Arg1, Arg2, Arg3>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3) -> Service?

    /// Retrieves the instance with the specified service type, 3 arguments to the factory closure and registration name.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: name        The registration name.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type,
    ///           3 arguments and name is found.
    func resolve<Service, Arg1, Arg2, Arg3>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3,
        name: String?) -> Service?

    /// Retrieves the instance with the specified service type and 4 arguments to the factory closure.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type
    ///           and 4 arguments is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4) -> Service?

    /// Retrieves the instance with the specified service type, 4 arguments to the factory closure and registration name.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    /// :param: name        The registration name.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type,
    ///           4 arguments and name is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4,
        name: String?) -> Service?

    /// Retrieves the instance with the specified service type and 5 arguments to the factory closure.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    /// :param: arg5        An argument to the factory closure as Arg5 type.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type
    ///           and 5 arguments is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5) -> Service?

    /// Retrieves the instance with the specified service type, 5 arguments to the factory closure and registration name.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    /// :param: arg5        An argument to the factory closure as Arg5 type.
    /// :param: name        The registration name.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type,
    ///           5 arguments and name is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5,
        name: String?) -> Service?

    /// Retrieves the instance with the specified service type and 6 arguments to the factory closure.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    /// :param: arg5        An argument to the factory closure as Arg5 type.
    /// :param: arg6        An argument to the factory closure as Arg6 type.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type
    ///           and 6 arguments is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6) -> Service?

    /// Retrieves the instance with the specified service type, 6 arguments to the factory closure and registration name.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    /// :param: arg5        An argument to the factory closure as Arg5 type.
    /// :param: arg6        An argument to the factory closure as Arg6 type.
    /// :param: name        The registration name.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type,
    ///           6 arguments and name is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6,
        name: String?) -> Service?

    /// Retrieves the instance with the specified service type and 7 arguments to the factory closure.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    /// :param: arg5        An argument to the factory closure as Arg5 type.
    /// :param: arg6        An argument to the factory closure as Arg6 type.
    /// :param: arg7        An argument to the factory closure as Arg7 type.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type
    ///           and 7 arguments is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7) -> Service?

    /// Retrieves the instance with the specified service type, 7 arguments to the factory closure and registration name.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    /// :param: arg5        An argument to the factory closure as Arg5 type.
    /// :param: arg6        An argument to the factory closure as Arg6 type.
    /// :param: arg7        An argument to the factory closure as Arg7 type.
    /// :param: name        The registration name.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type,
    ///           7 arguments and name is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7,
        name: String?) -> Service?

    /// Retrieves the instance with the specified service type and 8 arguments to the factory closure.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    /// :param: arg5        An argument to the factory closure as Arg5 type.
    /// :param: arg6        An argument to the factory closure as Arg6 type.
    /// :param: arg7        An argument to the factory closure as Arg7 type.
    /// :param: arg8        An argument to the factory closure as Arg8 type.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type
    ///           and 8 arguments is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8) -> Service?

    /// Retrieves the instance with the specified service type, 8 arguments to the factory closure and registration name.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    /// :param: arg5        An argument to the factory closure as Arg5 type.
    /// :param: arg6        An argument to the factory closure as Arg6 type.
    /// :param: arg7        An argument to the factory closure as Arg7 type.
    /// :param: arg8        An argument to the factory closure as Arg8 type.
    /// :param: name        The registration name.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type,
    ///           8 arguments and name is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8,
        name: String?) -> Service?

    /// Retrieves the instance with the specified service type and 9 arguments to the factory closure.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    /// :param: arg5        An argument to the factory closure as Arg5 type.
    /// :param: arg6        An argument to the factory closure as Arg6 type.
    /// :param: arg7        An argument to the factory closure as Arg7 type.
    /// :param: arg8        An argument to the factory closure as Arg8 type.
    /// :param: arg9        An argument to the factory closure as Arg9 type.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type
    ///           and 9 arguments is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8, arg9: Arg9) -> Service?

    /// Retrieves the instance with the specified service type, 9 arguments to the factory closure and registration name.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    /// :param: arg5        An argument to the factory closure as Arg5 type.
    /// :param: arg6        An argument to the factory closure as Arg6 type.
    /// :param: arg7        An argument to the factory closure as Arg7 type.
    /// :param: arg8        An argument to the factory closure as Arg8 type.
    /// :param: arg9        An argument to the factory closure as Arg9 type.
    /// :param: name        The registration name.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type,
    ///           9 arguments and name is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8, arg9: Arg9,
        name: String?) -> Service?

    /// Retrieves the instance with the specified service type and 10 arguments to the factory closure.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    /// :param: arg5        An argument to the factory closure as Arg5 type.
    /// :param: arg6        An argument to the factory closure as Arg6 type.
    /// :param: arg7        An argument to the factory closure as Arg7 type.
    /// :param: arg8        An argument to the factory closure as Arg8 type.
    /// :param: arg9        An argument to the factory closure as Arg9 type.
    /// :param: arg10        An argument to the factory closure as Arg10 type.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type
    ///           and 10 arguments is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8, arg9: Arg9, arg10: Arg10) -> Service?

    /// Retrieves the instance with the specified service type, 10 arguments to the factory closure and registration name.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    /// :param: arg5        An argument to the factory closure as Arg5 type.
    /// :param: arg6        An argument to the factory closure as Arg6 type.
    /// :param: arg7        An argument to the factory closure as Arg7 type.
    /// :param: arg8        An argument to the factory closure as Arg8 type.
    /// :param: arg9        An argument to the factory closure as Arg9 type.
    /// :param: arg10        An argument to the factory closure as Arg10 type.
    /// :param: name        The registration name.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type,
    ///           10 arguments and name is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8, arg9: Arg9, arg10: Arg10,
        name: String?) -> Service?

    /// Retrieves the instance with the specified service type and 11 arguments to the factory closure.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    /// :param: arg5        An argument to the factory closure as Arg5 type.
    /// :param: arg6        An argument to the factory closure as Arg6 type.
    /// :param: arg7        An argument to the factory closure as Arg7 type.
    /// :param: arg8        An argument to the factory closure as Arg8 type.
    /// :param: arg9        An argument to the factory closure as Arg9 type.
    /// :param: arg10        An argument to the factory closure as Arg10 type.
    /// :param: arg11        An argument to the factory closure as Arg11 type.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type
    ///           and 11 arguments is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8, arg9: Arg9, arg10: Arg10, arg11: Arg11) -> Service?

    /// Retrieves the instance with the specified service type, 11 arguments to the factory closure and registration name.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    /// :param: arg5        An argument to the factory closure as Arg5 type.
    /// :param: arg6        An argument to the factory closure as Arg6 type.
    /// :param: arg7        An argument to the factory closure as Arg7 type.
    /// :param: arg8        An argument to the factory closure as Arg8 type.
    /// :param: arg9        An argument to the factory closure as Arg9 type.
    /// :param: arg10        An argument to the factory closure as Arg10 type.
    /// :param: arg11        An argument to the factory closure as Arg11 type.
    /// :param: name        The registration name.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type,
    ///           11 arguments and name is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8, arg9: Arg9, arg10: Arg10, arg11: Arg11,
        name: String?) -> Service?

    /// Retrieves the instance with the specified service type and 12 arguments to the factory closure.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    /// :param: arg5        An argument to the factory closure as Arg5 type.
    /// :param: arg6        An argument to the factory closure as Arg6 type.
    /// :param: arg7        An argument to the factory closure as Arg7 type.
    /// :param: arg8        An argument to the factory closure as Arg8 type.
    /// :param: arg9        An argument to the factory closure as Arg9 type.
    /// :param: arg10        An argument to the factory closure as Arg10 type.
    /// :param: arg11        An argument to the factory closure as Arg11 type.
    /// :param: arg12        An argument to the factory closure as Arg12 type.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type
    ///           and 12 arguments is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11, Arg12>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8, arg9: Arg9, arg10: Arg10, arg11: Arg11, arg12: Arg12) -> Service?

    /// Retrieves the instance with the specified service type, 12 arguments to the factory closure and registration name.
    ///
    /// :param: serviceType The service type to resolve.
    /// :param: arg1        An argument to the factory closure as Arg1 type.
    /// :param: arg2        An argument to the factory closure as Arg2 type.
    /// :param: arg3        An argument to the factory closure as Arg3 type.
    /// :param: arg4        An argument to the factory closure as Arg4 type.
    /// :param: arg5        An argument to the factory closure as Arg5 type.
    /// :param: arg6        An argument to the factory closure as Arg6 type.
    /// :param: arg7        An argument to the factory closure as Arg7 type.
    /// :param: arg8        An argument to the factory closure as Arg8 type.
    /// :param: arg9        An argument to the factory closure as Arg9 type.
    /// :param: arg10        An argument to the factory closure as Arg10 type.
    /// :param: arg11        An argument to the factory closure as Arg11 type.
    /// :param: arg12        An argument to the factory closure as Arg12 type.
    /// :param: name        The registration name.
    ///
    /// :returns: The resolved service type instance, or nil if no registration for the service type,
    ///           12 arguments and name is found.
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11, Arg12>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8, arg9: Arg9, arg10: Arg10, arg11: Arg11, arg12: Arg12,
        name: String?) -> Service?

}
