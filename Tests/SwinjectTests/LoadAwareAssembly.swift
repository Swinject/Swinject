//
//  LoadAwareAssembly.swift
//  Swinject
//
//  Created by mike.owens on 12/9/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Swinject


class LoadAwareAssembly: Assembly {
    var onLoad: (Resolver) -> Void
    var loaded = false
    
    init(onLoad: @escaping (Resolver) -> Void) {
        self.onLoad = onLoad
    }
    
    func assemble(container: Container) {
        container.register(Animal.self) { r in
            return Cat(name: "Bojangles")
        }
    }
    
    func loaded(resolver: Resolver) {
        onLoad(resolver)
        loaded = true
    }
}
