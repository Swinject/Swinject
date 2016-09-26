//
//  DependencyAnalyzer.Arguments.swift
//  Swinject
//
//  Created by Markus Riegel on 25.09.16.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

//
// NOTICE:
//
// DependencyAnalyzer.Arguments.swift is generated from DependencyAnalyzer.Arguments.erb by ERB.
// Do NOT modify DependencyAnalyzer.Arguments.swift directly.
// Instead, modify DependencyAnalyzer.Arguments.erb and run `script/gencode` at the project root directory to generate the code.
//


import Foundation

// MARK: - Resolvable with Arguments
extension DependencyAnalyzer {
/// Retrieves the instance with the specified service type and 1 argument to the factory closure.
///
/// - Parameters:
///   - serviceType: The service type to resolve.
///   - argument:   1 argument to pass to the factory closure.
///
/// - Returns: The resolved service type instance, or nil if no registration for the service type
///            and 1 argument is found in the `Container`.
public func resolve<Service, Arg1>(
serviceType: Service.Type,
argument: Arg1) -> Service?
{
return resolve(serviceType, name: nil, argument: argument)
}

/// Retrieves the instance with the specified service type, 1 argument to the factory closure and registration name.
///
/// - Parameters:
///   - serviceType: The service type to resolve.
///   - name:        The registration name.
///   - argument:   1 argument to pass to the factory closure.
///
/// - Returns: The resolved service type instance, or nil if no registration for the service type,
///            1 argument and name is found in the `Container`.
public func resolve<Service, Arg1>(
serviceType: Service.Type,
name: String?,
argument: Arg1) -> Service?
{
typealias FactoryType = (ResolverType, Arg1) -> Service
return resolveImpl(name) { (factory: FactoryType) in factory(self, argument) }
}

/// Retrieves the instance with the specified service type and tuple of 2 arguments to the factory closure.
///
/// - Parameters:
///   - serviceType: The service type to resolve.
///   - arguments:   Tuple of 2 arguments to pass to the factory closure.
///
/// - Returns: The resolved service type instance, or nil if no registration for the service type
///            and tuple of 2 arguments is found in the `Container`.
public func resolve<Service, Arg1, Arg2>(
serviceType: Service.Type,
arguments: (Arg1, Arg2)) -> Service?
{
return resolve(serviceType, name: nil, arguments: arguments)
}

/// Retrieves the instance with the specified service type, tuple of 2 arguments to the factory closure and registration name.
///
/// - Parameters:
///   - serviceType: The service type to resolve.
///   - name:        The registration name.
///   - arguments:   Tuple of 2 arguments to pass to the factory closure.
///
/// - Returns: The resolved service type instance, or nil if no registration for the service type,
///            tuple of 2 arguments and name is found in the `Container`.
public func resolve<Service, Arg1, Arg2>(
serviceType: Service.Type,
name: String?,
arguments: (Arg1, Arg2)) -> Service?
{
typealias FactoryType = (ResolverType, Arg1, Arg2) -> Service
return resolveImpl(name) { (factory: FactoryType) in factory(self, arguments.0, arguments.1) }
}

/// Retrieves the instance with the specified service type and tuple of 3 arguments to the factory closure.
///
/// - Parameters:
///   - serviceType: The service type to resolve.
///   - arguments:   Tuple of 3 arguments to pass to the factory closure.
///
/// - Returns: The resolved service type instance, or nil if no registration for the service type
///            and tuple of 3 arguments is found in the `Container`.
public func resolve<Service, Arg1, Arg2, Arg3>(
serviceType: Service.Type,
arguments: (Arg1, Arg2, Arg3)) -> Service?
{
return resolve(serviceType, name: nil, arguments: arguments)
}

/// Retrieves the instance with the specified service type, tuple of 3 arguments to the factory closure and registration name.
///
/// - Parameters:
///   - serviceType: The service type to resolve.
///   - name:        The registration name.
///   - arguments:   Tuple of 3 arguments to pass to the factory closure.
///
/// - Returns: The resolved service type instance, or nil if no registration for the service type,
///            tuple of 3 arguments and name is found in the `Container`.
public func resolve<Service, Arg1, Arg2, Arg3>(
serviceType: Service.Type,
name: String?,
arguments: (Arg1, Arg2, Arg3)) -> Service?
{
typealias FactoryType = (ResolverType, Arg1, Arg2, Arg3) -> Service
return resolveImpl(name) { (factory: FactoryType) in factory(self, arguments.0, arguments.1, arguments.2) }
}

/// Retrieves the instance with the specified service type and tuple of 4 arguments to the factory closure.
///
/// - Parameters:
///   - serviceType: The service type to resolve.
///   - arguments:   Tuple of 4 arguments to pass to the factory closure.
///
/// - Returns: The resolved service type instance, or nil if no registration for the service type
///            and tuple of 4 arguments is found in the `Container`.
public func resolve<Service, Arg1, Arg2, Arg3, Arg4>(
serviceType: Service.Type,
arguments: (Arg1, Arg2, Arg3, Arg4)) -> Service?
{
return resolve(serviceType, name: nil, arguments: arguments)
}

/// Retrieves the instance with the specified service type, tuple of 4 arguments to the factory closure and registration name.
///
/// - Parameters:
///   - serviceType: The service type to resolve.
///   - name:        The registration name.
///   - arguments:   Tuple of 4 arguments to pass to the factory closure.
///
/// - Returns: The resolved service type instance, or nil if no registration for the service type,
///            tuple of 4 arguments and name is found in the `Container`.
public func resolve<Service, Arg1, Arg2, Arg3, Arg4>(
serviceType: Service.Type,
name: String?,
arguments: (Arg1, Arg2, Arg3, Arg4)) -> Service?
{
typealias FactoryType = (ResolverType, Arg1, Arg2, Arg3, Arg4) -> Service
return resolveImpl(name) { (factory: FactoryType) in factory(self, arguments.0, arguments.1, arguments.2, arguments.3) }
}

/// Retrieves the instance with the specified service type and tuple of 5 arguments to the factory closure.
///
/// - Parameters:
///   - serviceType: The service type to resolve.
///   - arguments:   Tuple of 5 arguments to pass to the factory closure.
///
/// - Returns: The resolved service type instance, or nil if no registration for the service type
///            and tuple of 5 arguments is found in the `Container`.
public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(
serviceType: Service.Type,
arguments: (Arg1, Arg2, Arg3, Arg4, Arg5)) -> Service?
{
return resolve(serviceType, name: nil, arguments: arguments)
}

/// Retrieves the instance with the specified service type, tuple of 5 arguments to the factory closure and registration name.
///
/// - Parameters:
///   - serviceType: The service type to resolve.
///   - name:        The registration name.
///   - arguments:   Tuple of 5 arguments to pass to the factory closure.
///
/// - Returns: The resolved service type instance, or nil if no registration for the service type,
///            tuple of 5 arguments and name is found in the `Container`.
public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(
serviceType: Service.Type,
name: String?,
arguments: (Arg1, Arg2, Arg3, Arg4, Arg5)) -> Service?
{
typealias FactoryType = (ResolverType, Arg1, Arg2, Arg3, Arg4, Arg5) -> Service
return resolveImpl(name) { (factory: FactoryType) in factory(self, arguments.0, arguments.1, arguments.2, arguments.3, arguments.4) }
}

/// Retrieves the instance with the specified service type and tuple of 6 arguments to the factory closure.
///
/// - Parameters:
///   - serviceType: The service type to resolve.
///   - arguments:   Tuple of 6 arguments to pass to the factory closure.
///
/// - Returns: The resolved service type instance, or nil if no registration for the service type
///            and tuple of 6 arguments is found in the `Container`.
public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(
serviceType: Service.Type,
arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6)) -> Service?
{
return resolve(serviceType, name: nil, arguments: arguments)
}

/// Retrieves the instance with the specified service type, tuple of 6 arguments to the factory closure and registration name.
///
/// - Parameters:
///   - serviceType: The service type to resolve.
///   - name:        The registration name.
///   - arguments:   Tuple of 6 arguments to pass to the factory closure.
///
/// - Returns: The resolved service type instance, or nil if no registration for the service type,
///            tuple of 6 arguments and name is found in the `Container`.
public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(
serviceType: Service.Type,
name: String?,
arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6)) -> Service?
{
typealias FactoryType = (ResolverType, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6) -> Service
return resolveImpl(name) { (factory: FactoryType) in factory(self, arguments.0, arguments.1, arguments.2, arguments.3, arguments.4, arguments.5) }
}

/// Retrieves the instance with the specified service type and tuple of 7 arguments to the factory closure.
///
/// - Parameters:
///   - serviceType: The service type to resolve.
///   - arguments:   Tuple of 7 arguments to pass to the factory closure.
///
/// - Returns: The resolved service type instance, or nil if no registration for the service type
///            and tuple of 7 arguments is found in the `Container`.
public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(
serviceType: Service.Type,
arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7)) -> Service?
{
return resolve(serviceType, name: nil, arguments: arguments)
}

/// Retrieves the instance with the specified service type, tuple of 7 arguments to the factory closure and registration name.
///
/// - Parameters:
///   - serviceType: The service type to resolve.
///   - name:        The registration name.
///   - arguments:   Tuple of 7 arguments to pass to the factory closure.
///
/// - Returns: The resolved service type instance, or nil if no registration for the service type,
///            tuple of 7 arguments and name is found in the `Container`.
public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(
serviceType: Service.Type,
name: String?,
arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7)) -> Service?
{
typealias FactoryType = (ResolverType, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7) -> Service
return resolveImpl(name) { (factory: FactoryType) in factory(self, arguments.0, arguments.1, arguments.2, arguments.3, arguments.4, arguments.5, arguments.6) }
}

/// Retrieves the instance with the specified service type and tuple of 8 arguments to the factory closure.
///
/// - Parameters:
///   - serviceType: The service type to resolve.
///   - arguments:   Tuple of 8 arguments to pass to the factory closure.
///
/// - Returns: The resolved service type instance, or nil if no registration for the service type
///            and tuple of 8 arguments is found in the `Container`.
public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(
serviceType: Service.Type,
arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8)) -> Service?
{
return resolve(serviceType, name: nil, arguments: arguments)
}

/// Retrieves the instance with the specified service type, tuple of 8 arguments to the factory closure and registration name.
///
/// - Parameters:
///   - serviceType: The service type to resolve.
///   - name:        The registration name.
///   - arguments:   Tuple of 8 arguments to pass to the factory closure.
///
/// - Returns: The resolved service type instance, or nil if no registration for the service type,
///            tuple of 8 arguments and name is found in the `Container`.
public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(
serviceType: Service.Type,
name: String?,
arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8)) -> Service?
{
typealias FactoryType = (ResolverType, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8) -> Service
return resolveImpl(name) { (factory: FactoryType) in factory(self, arguments.0, arguments.1, arguments.2, arguments.3, arguments.4, arguments.5, arguments.6, arguments.7) }
}

/// Retrieves the instance with the specified service type and tuple of 9 arguments to the factory closure.
///
/// - Parameters:
///   - serviceType: The service type to resolve.
///   - arguments:   Tuple of 9 arguments to pass to the factory closure.
///
/// - Returns: The resolved service type instance, or nil if no registration for the service type
///            and tuple of 9 arguments is found in the `Container`.
public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(
serviceType: Service.Type,
arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9)) -> Service?
{
return resolve(serviceType, name: nil, arguments: arguments)
}

/// Retrieves the instance with the specified service type, tuple of 9 arguments to the factory closure and registration name.
///
/// - Parameters:
///   - serviceType: The service type to resolve.
///   - name:        The registration name.
///   - arguments:   Tuple of 9 arguments to pass to the factory closure.
///
/// - Returns: The resolved service type instance, or nil if no registration for the service type,
///            tuple of 9 arguments and name is found in the `Container`.
public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(
serviceType: Service.Type,
name: String?,
arguments: (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9)) -> Service?
{
typealias FactoryType = (ResolverType, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9) -> Service
return resolveImpl(name) { (factory: FactoryType) in factory(self, arguments.0, arguments.1, arguments.2, arguments.3, arguments.4, arguments.5, arguments.6, arguments.7, arguments.8) }
}

}
