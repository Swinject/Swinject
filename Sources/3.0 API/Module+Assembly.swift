//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

extension Swinject.Module: Assembly {
    public func assemble(container: Container) {
        for binding in tree.bindings {
            for key in binding.keys {
                container.bindings[key] = binding
            }
        }
        for inclusion in tree.modules {
            inclusion.module.assemble(container: container)
        }
    }
}
