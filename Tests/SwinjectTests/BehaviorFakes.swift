//
//  BehaviorFakes.swift
//  Swinject
//
//  Created by Jakub Vaňo on 06/03/2018.
//  Copyright © 2018 Swinject Contributors. All rights reserved.
//

@testable import Swinject

class BehaviorSpy: Behavior {
    var entries = [ServiceEntryProtocol]()
    var names = [String?]()
    var types = [Any.Type]()

    func container<Type, Service>(
        _ container: Container,
        didRegisterType type: Type.Type,
        toService entry: ServiceEntry<Service>,
        withName name: String?
    ) {
        entries.append(entry)
        names.append(name)
        types.append(type)
    }
}
