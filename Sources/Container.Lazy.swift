//
//  Container.Lazy.swift
//  Swinject
//
//  Created by Jakub Vaňo on 07/03/2018.
//  Copyright © 2018 Swinject Contributors. All rights reserved.
//

extension Container {
    public func enableLazy<Service>(_ entry: ServiceEntry<Service>) {
        register(Lazy<Service>.self) { Lazy(resolver: $0, graphIdentifier: ($0 as! Container).currentObjectGraph!) }
            .inObjectScope(entry.objectScope)
    }
}
