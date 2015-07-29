//
//  Syntax.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/24/15.
//  Copyright © 2015 DevSwinject. All rights reserved.
//

import Foundation

// Commented out because of a compiler abort on the unit test project if Container returns RegistrationType.
/*
public protocol RegistrationType {
    typealias Service
    func initCompleted<Service, R: RegistrationType>(completed: (Container, Service) -> ()) -> R
    func inObjectScope<R: RegistrationType>(scope: ObjectScope) -> R
}
*/

public protocol Resolvable {
    func resolve<Service>(serviceType: Service.Type) -> Service?
    func resolve<Service, Arg1>(serviceType: Service.Type, arg1: Arg1) -> Service?
    func resolve<Service, Arg1, Arg2>(serviceType: Service.Type, arg1: Arg1, arg2: Arg2) -> Service?

    func resolve<Service>(serviceType: Service.Type, name: String?) -> Service?
    func resolve<Service, Arg1>(serviceType: Service.Type, arg1: Arg1, name: String?) -> Service?
    func resolve<Service, Arg1, Arg2>(serviceType: Service.Type, arg1: Arg1, arg2: Arg2, name: String?) -> Service?
}
