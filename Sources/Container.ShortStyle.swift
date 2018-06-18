//
//  Container.ShortStyle.erb
//  Swinject
//
//  Created by Vincent Saluzzo on 18/06/2018.
//  Copyright © 2018 Swinject Contributors. All rights reserved.
//

// NOTICE:
//
// Container.Arguments.swift is generated from Container.ShortStyle.erb by ERB.
// Do NOT modify Container.ShortStyle.swift directly.
// Instead, modify Container.ShortStyle.swift and run `script/gencode` at the project root directory to generate the code.
//


import Foundation

extension Container {
    
    public func resolve<Type>() -> Type? {
        return resolve(Type.self)
    }
                                
    /// Retrieves the instance with the specified service type and 1 argument to the factory closure.
    ///
    /// - Parameters:
    ///   - argument:   1 argument to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and 1 argument is found in the `Container`.
    public func resolve<Type, Arg1>(argument: Arg1) -> Type? {
        return resolve(Type.self, name: nil, argument: argument)
    }
                                
    /// Retrieves the instance with the specified service type and list of 2 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - arguments:   List of 2 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and list of 2 arguments is found in the `Container`.
    public func resolve<Type, Arg1, Arg2>(arguments arg1: Arg1, _ arg2: Arg2) -> Type? {
        return resolve(Type.self, name: nil, arguments: arg1, arg2)
    }
                                
    /// Retrieves the instance with the specified service type and list of 3 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - arguments:   List of 3 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and list of 3 arguments is found in the `Container`.
    public func resolve<Type, Arg1, Arg2, Arg3>(arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> Type? {
        return resolve(Type.self, name: nil, arguments: arg1, arg2, arg3)
    }
                                
    /// Retrieves the instance with the specified service type and list of 4 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - arguments:   List of 4 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and list of 4 arguments is found in the `Container`.
    public func resolve<Type, Arg1, Arg2, Arg3, Arg4>(arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) -> Type? {
        return resolve(Type.self, name: nil, arguments: arg1, arg2, arg3, arg4)
    }
                                
    /// Retrieves the instance with the specified service type and list of 5 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - arguments:   List of 5 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and list of 5 arguments is found in the `Container`.
    public func resolve<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5) -> Type? {
        return resolve(Type.self, name: nil, arguments: arg1, arg2, arg3, arg4, arg5)
    }
                                
    /// Retrieves the instance with the specified service type and list of 6 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - arguments:   List of 6 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and list of 6 arguments is found in the `Container`.
    public func resolve<Type, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6) -> Type? {
        return resolve(Type.self, name: nil, arguments: arg1, arg2, arg3, arg4, arg5, arg6)
    }
                                
    /// Retrieves the instance with the specified service type and list of 7 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - arguments:   List of 7 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and list of 7 arguments is found in the `Container`.
    public func resolve<Type, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7) -> Type? {
        return resolve(Type.self, name: nil, arguments: arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }
                                
    /// Retrieves the instance with the specified service type and list of 8 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - arguments:   List of 8 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and list of 8 arguments is found in the `Container`.
    public func resolve<Type, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7, _ arg8: Arg8) -> Type? {
        return resolve(Type.self, name: nil, arguments: arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }
                                
    /// Retrieves the instance with the specified service type and list of 9 arguments to the factory closure.
    ///
    /// - Parameters:
    ///   - arguments:   List of 9 arguments to pass to the factory closure.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and list of 9 arguments is found in the `Container`.
    public func resolve<Type, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7, _ arg8: Arg8, _ arg9: Arg9) -> Type? {
        return resolve(Type.self, name: nil, arguments: arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }
    }
