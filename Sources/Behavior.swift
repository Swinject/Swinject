//
//  Behavior.swift
//  Swinject-iOS
//
//  Created by Jakub Vaňo on 16/02/2018.
//  Copyright © 2018 Swinject Contributors. All rights reserved.
//

public protocol Behavior {
    func container<Service>(
        _ container: Container,
        didRegisterService entry: ServiceEntry<Service>,
        withName name: String?
    )
}
