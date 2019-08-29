//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Swinject

class LoadAwareAssembly: Assembly {
    var onLoad: (Resolver) -> Void
    var loaded = false

    init(onLoad: @escaping (Resolver) -> Void) {
        self.onLoad = onLoad
    }

    func assemble(container: Container) {
        container.register(Animal.self) { _ in
            Cat(name: "Bojangles")
        }
    }

    func loaded(resolver: Resolver) {
        onLoad(resolver)
        loaded = true
    }
}
