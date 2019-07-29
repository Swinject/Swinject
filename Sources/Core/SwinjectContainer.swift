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
    struct BindingEntry {
        let binding: Binding
        let key: BindingKey
        let properties: BindingProperties
        let canOverride: Bool
        let canOverrideSilently: Bool
    }

    // TODO: Create throwing version for testing convenience
    static func makeContainer(with tree: SwinjectTree, _ allowsSilentOverride: Bool) -> Swinject.Container {
        let allModuleNames = makeModules(with: tree).map { $0.name }
        assert(allModuleNames.count == Set(allModuleNames).count)

        let allBindings = makeBindings(with: tree, canOverrideSilently: allowsSilentOverride)
            .reduce(into: [BindingKey: Binding]()) { dict, entry in
                assert(entry.canOverride || !entry.properties.overrides)
                assert((dict[entry.key] == nil) != entry.properties.overrides || entry.canOverrideSilently)
                dict[entry.key] = entry.binding
            }
            .map { $0.value }

        return .init(
            bindings: allBindings,
            translators: tree.translators
        )
    }

    static func makeModules(with tree: SwinjectTree) -> [Swinject.Module] {
        return tree.modules.map { $0.module } + tree.modules.flatMap { makeModules(with: $0.module.tree) }
    }

    static func makeBindings(
        with tree: SwinjectTree,
        canOverride: Bool? = nil,
        canOverrideSilently: Bool
    ) -> [BindingEntry] {
        return tree.bindings
            .map { BindingEntry(
                binding: $0,
                key: $0.key,
                properties: $0.properties,
                canOverride: canOverride ?? true,
                canOverrideSilently: canOverrideSilently
            ) }
            + tree.modules.flatMap { makeBindings(
                with: $0.module.tree,
                canOverride: canOverride ?? $0.canOverride,
                canOverrideSilently: $0.module.allowsSilentOverride
            ) }
    }
}
