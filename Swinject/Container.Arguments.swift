//
//  Container.Arguments.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 8/18/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

//
// NOTICE:
//
// Container.Arguments.swift is generated from Container.Arguments.erb by ERB.
// Do NOT modify Container.Arguments.swift directly.
// Instead, modify Container.Arguments.erb and run `script/gencode` at the project root directory to generate the code.
//


import Foundation

// MARK: - Registeration with Arguments
extension Container {
    public func register<Service, Arg1>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    public func register<Service, Arg1, Arg2>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1, Arg2) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    public func register<Service, Arg1, Arg2, Arg3>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1, Arg2, Arg3) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    public func register<Service, Arg1, Arg2, Arg3, Arg4>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1, Arg2, Arg3, Arg4) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    public func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    public func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    public func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    public func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    public func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    public func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    public func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

    public func register<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11, Arg12>(
        serviceType: Service.Type,
        name: String? = nil,
        factory: (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11, Arg12) -> Service) -> ServiceEntry<Service>
    {
        return registerImpl(serviceType, factory: factory, name: name)
    }

}

// MARK: - Resolvable with Arguments
extension Container {
    public func resolve<Service, Arg1>(
        serviceType: Service.Type,
        arg1: Arg1) -> Service?
    {
        return resolve(serviceType, arg1: arg1, name: nil)
    }

    public func resolve<Service, Arg1>(
        serviceType: Service.Type,
        arg1: Arg1,
        name: String?) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arg1) }
    }

    public func resolve<Service, Arg1, Arg2>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2) -> Service?
    {
        return resolve(serviceType, arg1: arg1, arg2: arg2, name: nil)
    }

    public func resolve<Service, Arg1, Arg2>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2,
        name: String?) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1, Arg2) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arg1, arg2) }
    }

    public func resolve<Service, Arg1, Arg2, Arg3>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3) -> Service?
    {
        return resolve(serviceType, arg1: arg1, arg2: arg2, arg3: arg3, name: nil)
    }

    public func resolve<Service, Arg1, Arg2, Arg3>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3,
        name: String?) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1, Arg2, Arg3) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arg1, arg2, arg3) }
    }

    public func resolve<Service, Arg1, Arg2, Arg3, Arg4>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4) -> Service?
    {
        return resolve(serviceType, arg1: arg1, arg2: arg2, arg3: arg3, arg4: arg4, name: nil)
    }

    public func resolve<Service, Arg1, Arg2, Arg3, Arg4>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4,
        name: String?) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1, Arg2, Arg3, Arg4) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arg1, arg2, arg3, arg4) }
    }

    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5) -> Service?
    {
        return resolve(serviceType, arg1: arg1, arg2: arg2, arg3: arg3, arg4: arg4, arg5: arg5, name: nil)
    }

    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5,
        name: String?) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arg1, arg2, arg3, arg4, arg5) }
    }

    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6) -> Service?
    {
        return resolve(serviceType, arg1: arg1, arg2: arg2, arg3: arg3, arg4: arg4, arg5: arg5, arg6: arg6, name: nil)
    }

    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6,
        name: String?) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arg1, arg2, arg3, arg4, arg5, arg6) }
    }

    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7) -> Service?
    {
        return resolve(serviceType, arg1: arg1, arg2: arg2, arg3: arg3, arg4: arg4, arg5: arg5, arg6: arg6, arg7: arg7, name: nil)
    }

    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7,
        name: String?) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arg1, arg2, arg3, arg4, arg5, arg6, arg7) }
    }

    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8) -> Service?
    {
        return resolve(serviceType, arg1: arg1, arg2: arg2, arg3: arg3, arg4: arg4, arg5: arg5, arg6: arg6, arg7: arg7, arg8: arg8, name: nil)
    }

    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8,
        name: String?) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8) }
    }

    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8, arg9: Arg9) -> Service?
    {
        return resolve(serviceType, arg1: arg1, arg2: arg2, arg3: arg3, arg4: arg4, arg5: arg5, arg6: arg6, arg7: arg7, arg8: arg8, arg9: arg9, name: nil)
    }

    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8, arg9: Arg9,
        name: String?) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9) }
    }

    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8, arg9: Arg9, arg10: Arg10) -> Service?
    {
        return resolve(serviceType, arg1: arg1, arg2: arg2, arg3: arg3, arg4: arg4, arg5: arg5, arg6: arg6, arg7: arg7, arg8: arg8, arg9: arg9, arg10: arg10, name: nil)
    }

    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8, arg9: Arg9, arg10: Arg10,
        name: String?) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10) }
    }

    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8, arg9: Arg9, arg10: Arg10, arg11: Arg11) -> Service?
    {
        return resolve(serviceType, arg1: arg1, arg2: arg2, arg3: arg3, arg4: arg4, arg5: arg5, arg6: arg6, arg7: arg7, arg8: arg8, arg9: arg9, arg10: arg10, arg11: arg11, name: nil)
    }

    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8, arg9: Arg9, arg10: Arg10, arg11: Arg11,
        name: String?) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11) }
    }

    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11, Arg12>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8, arg9: Arg9, arg10: Arg10, arg11: Arg11, arg12: Arg12) -> Service?
    {
        return resolve(serviceType, arg1: arg1, arg2: arg2, arg3: arg3, arg4: arg4, arg5: arg5, arg6: arg6, arg7: arg7, arg8: arg8, arg9: arg9, arg10: arg10, arg11: arg11, arg12: arg12, name: nil)
    }

    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11, Arg12>(
        serviceType: Service.Type,
        arg1: Arg1, arg2: Arg2, arg3: Arg3, arg4: Arg4, arg5: Arg5, arg6: Arg6, arg7: Arg7, arg8: Arg8, arg9: Arg9, arg10: Arg10, arg11: Arg11, arg12: Arg12,
        name: String?) -> Service?
    {
        typealias FactoryType = (Resolvable, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11, Arg12) -> Service
        return resolveImpl(name) { (factory: FactoryType) in factory(self, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12) }
    }

}
