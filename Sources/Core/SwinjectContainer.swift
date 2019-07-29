//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

extension Swinject {
    struct Container {
        let bindings: [Binding]
        let translators: [AnyContextTranslator]
    }
}

extension Swinject.Container {
    static func makeContainer(with tree: SwinjectTree) -> Swinject.Container {
        let allModuleNames = makeModules(with: tree).map { $0.name }
        assert(allModuleNames.count == Set(allModuleNames).count)

        let allBindings = makeBindings(with: tree)
            .reduce(into: [BindingKey: Binding]()) { dict, binding in
                assert((dict[binding.key] == nil) != binding.properties.overrides)
                dict[binding.key] = binding
            }
            .map { $0.value }

        return .init(
            bindings: allBindings,
            translators: tree.translators
        )
    }

    static func makeModules(with tree: SwinjectTree) -> [Swinject.Module] {
        return tree.modules + tree.modules.flatMap { makeModules(with: $0.tree) }
    }

    static func makeBindings(with tree: SwinjectTree) -> [Binding] {
        return tree.bindings + tree.modules.flatMap { makeBindings(with: $0.tree) }
    }
}
