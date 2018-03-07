//
//  Lazy.swift
//  Swinject
//
//  Created by Jakub Vaňo on 07/03/2018.
//  Copyright © 2018 Swinject Contributors. All rights reserved.
//

public final class Lazy<Service> {
    private let resolver: Resolver
    private var _instance: Service?

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    public var instance: Service {
        if let instance = _instance {
            return instance
        } else {
            let newInstance = resolver.resolve(Service.self)!
            _instance = newInstance
            return newInstance
        }
    }
}
