//
//  RegistrationNameAssociatable.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 8/1/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

internal protocol RegistrationNameAssociatable: AnyObject {
    var swinjectRegistrationName: String? { get set }
}
