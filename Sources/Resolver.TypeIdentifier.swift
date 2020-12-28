//
//  Resolver.TypeIdentifier.swift
//  Swinject-iOS
//
//  Created by Benjamin Lavialle on 01/12/2020.
//  Copyright © 2018 Swinject Contributors. All rights reserved.
//

//
// NOTICE:
//
// Resolver.TypeIdentifier.swift is generated from Resolver.TypeIdentifier.erb by ERB.
// Do NOT modify Resolver.TypeIdentifier.swift directly.
// Instead, modify Resolver.TypeIdentifier.erb and run `script/gencode` at the project root directory to generate the code.
//

extension Resolver {

    /// Retrieves the instance with the specified service type and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - identifier:  The registration identifier.
    ///
    /// - Returns: The resolved service type instance, or nil if no service with the identifier is found.
    @discardableResult
    public func resolve<Service: Identifiable>(
        _ serviceType: Service.Type = Service.self,
        identifier: Service.Identifier? = nil
    ) -> Service? {
        resolve(serviceType, name: identifier?.rawValue)
    }

    /// Retrieves the instance with the specified service type, 1 argument to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - identifier:  The registration identifier.
    ///   - argument:   1 argument to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            1 argument and identifier is found.
    public func resolve<Service: Identifiable, Arg1>(
        _ serviceType: Service.Type = Service.self,
        identifier: Service.Identifier? = nil,
        argument: Arg1
    ) -> Service? {
        resolve(serviceType, name: identifier?.rawValue, argument: argument)
    }

    /// Retrieves the instance with the specified service type, list of 2 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - identifier:  The registration identifier.
    ///   - arguments:   List of 2 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            list of 2 arguments and identifier is found.
    public func resolve<Service: Identifiable, Arg1, Arg2>(
        _ serviceType: Service.Type = Service.self,
        identifier: Service.Identifier? = nil,
        arguments arg1: Arg1, _ arg2: Arg2
    ) -> Service? {
        resolve(serviceType, name: identifier?.rawValue, arguments: arg1, arg2)
    }

    /// Retrieves the instance with the specified service type, list of 3 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - identifier:  The registration identifier.
    ///   - arguments:   List of 3 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            list of 3 arguments and identifier is found.
    public func resolve<Service: Identifiable, Arg1, Arg2, Arg3>(
        _ serviceType: Service.Type = Service.self,
        identifier: Service.Identifier? = nil,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3
    ) -> Service? {
        resolve(serviceType, name: identifier?.rawValue, arguments: arg1, arg2, arg3)
    }

    /// Retrieves the instance with the specified service type, list of 4 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - identifier:  The registration identifier.
    ///   - arguments:   List of 4 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            list of 4 arguments and identifier is found.
    public func resolve<Service: Identifiable, Arg1, Arg2, Arg3, Arg4>(
        _ serviceType: Service.Type = Service.self,
        identifier: Service.Identifier? = nil,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4
    ) -> Service? {
        resolve(serviceType, name: identifier?.rawValue, arguments: arg1, arg2, arg3, arg4)
    }

    /// Retrieves the instance with the specified service type, list of 5 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - identifier:  The registration identifier.
    ///   - arguments:   List of 5 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            list of 5 arguments and identifier is found.
    public func resolve<Service: Identifiable, Arg1, Arg2, Arg3, Arg4, Arg5>(
        _ serviceType: Service.Type = Service.self,
        identifier: Service.Identifier? = nil,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5
    ) -> Service? {
        resolve(serviceType, name: identifier?.rawValue, arguments: arg1, arg2, arg3, arg4, arg5)
    }

    /// Retrieves the instance with the specified service type, list of 6 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - identifier:  The registration identifier.
    ///   - arguments:   List of 6 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            list of 6 arguments and identifier is found.
    public func resolve<Service: Identifiable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(
        _ serviceType: Service.Type = Service.self,
        identifier: Service.Identifier? = nil,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6
    ) -> Service? {
        resolve(serviceType, name: identifier?.rawValue, arguments: arg1, arg2, arg3, arg4, arg5, arg6)
    }

    /// Retrieves the instance with the specified service type, list of 7 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - identifier:  The registration identifier.
    ///   - arguments:   List of 7 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            list of 7 arguments and identifier is found.
    public func resolve<Service: Identifiable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(
        _ serviceType: Service.Type = Service.self,
        identifier: Service.Identifier? = nil,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7
    ) -> Service? {
        resolve(serviceType, name: identifier?.rawValue, arguments: arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    /// Retrieves the instance with the specified service type, list of 8 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - identifier:  The registration identifier.
    ///   - arguments:   List of 8 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            list of 8 arguments and identifier is found.
    public func resolve<Service: Identifiable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(
        _ serviceType: Service.Type = Service.self,
        identifier: Service.Identifier? = nil,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7, _ arg8: Arg8
    ) -> Service? {
        resolve(serviceType, name: identifier?.rawValue, arguments: arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    /// Retrieves the instance with the specified service type, list of 9 arguments to the factory closure and registration name.
    ///
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - identifier:  The registration identifier.
    ///   - arguments:   List of 9 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type,
    ///            list of 9 arguments and identifier is found.
    public func resolve<Service: Identifiable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(
        _ serviceType: Service.Type = Service.self,
        identifier: Service.Identifier? = nil,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7, _ arg8: Arg8, _ arg9: Arg9
    ) -> Service? {
        resolve(serviceType, name: identifier?.rawValue, arguments: arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

}
