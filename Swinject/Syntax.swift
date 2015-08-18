//
//  Syntax.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/24/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
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
