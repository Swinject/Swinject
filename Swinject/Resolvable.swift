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
    func resolve<Service>(serviceType: Service.Type) -> Service?

    func resolve<Service>(serviceType: Service.Type, name: String?) -> Service?

    func resolve<Service, Arg1>(
        serviceType: Service.Type,
        arg1: Arg1) -> Service?

    func resolve<Service, Arg1>(
        serviceType: Service.Type,
        arg1: Arg1,
        name: String?) -> Service?

    func resolve<Service, Arg1, Arg2>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2) -> Service?

    func resolve<Service, Arg1, Arg2>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2,
        name: String?) -> Service?

    func resolve<Service, Arg1, Arg2, Arg3>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3) -> Service?

    func resolve<Service, Arg1, Arg2, Arg3>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3,
        name: String?) -> Service?

    func resolve<Service, Arg1, Arg2, Arg3, Arg4>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4) -> Service?

    func resolve<Service, Arg1, Arg2, Arg3, Arg4>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4,
        name: String?) -> Service?

    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5) -> Service?

    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5,
        name: String?) -> Service?

    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6) -> Service?

    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6,
        name: String?) -> Service?

    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7) -> Service?

    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7,
        name: String?) -> Service?

    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8) -> Service?

    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8,
        name: String?) -> Service?

    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8, arg9: Arg9) -> Service?

    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8, arg9: Arg9,
        name: String?) -> Service?

    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8, arg9: Arg9, arg10: Arg10) -> Service?

    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8, arg9: Arg9, arg10: Arg10,
        name: String?) -> Service?

    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8, arg9: Arg9, arg10: Arg10, arg11: Arg11) -> Service?

    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8, arg9: Arg9, arg10: Arg10, arg11: Arg11,
        name: String?) -> Service?

    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11, Arg12>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8, arg9: Arg9, arg10: Arg10, arg11: Arg11, arg12: Arg12) -> Service?

    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11, Arg12>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8, arg9: Arg9, arg10: Arg10, arg11: Arg11, arg12: Arg12,
        name: String?) -> Service?

}
