//
//  LoadAwareAssembly.swift
//  Swinject
//
//  Created by mike.owens on 12/9/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Swinject


class LoadAwareAssembly: AssemblyType {
    var onLoad: (ResolverType) -> Void
    var loaded = false
    
    init(onLoad: (ResolverType) -> Void) {
        self.onLoad = onLoad
    }
    
    func assemble(container: Container) {
        container.register(AnimalType.self) { r in
            return Cat(name: "Bojangles")
        }
    }
    
    func loaded(resolver: ResolverType) {
        onLoad(resolver)
        loaded = true
    }
}
