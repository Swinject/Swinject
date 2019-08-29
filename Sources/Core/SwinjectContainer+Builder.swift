//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

extension SwinjectContainer {
    struct Builder {
        let tree: SwinjectTree
        let properties: Swinject.Properties
    }
}

extension SwinjectContainer.Builder {
    func makeContainer() -> SwinjectContainer {
        do { return try makeContainerOrThrow() } catch { fatalError("\(error)") }
    }

    private func makeContainerOrThrow() throws -> SwinjectContainer {
        try checkDuplicitModules()
        let container = SwinjectContainer(
            bindings: try collectBindings(),
            translators: tree.translators
        )
        try container.checkDependencies()
        return container
    }
}

extension SwinjectContainer.Builder {
    private func checkDuplicitModules() throws {
        let names = collectModules(from: tree).map { $0.name }
        if names.containsDuplicates { throw DuplicateModules() }
    }

    private func collectModules(from tree: SwinjectTree) -> [Swinject.Module] {
        return tree.modules.map { $0.module } + tree.modules.flatMap { collectModules(from: $0.module.tree) }
    }
}

extension SwinjectContainer.Builder {
    private struct BindingEntry {
        let binding: AnyBinding
        let key: BindingKey
        let overrides: Bool
        let canOverride: Bool
        let canOverrideSilently: Bool
    }

    private func collectBindings() throws -> [BindingKey: AnyBinding] {
        return try collectBindingEntries(from: tree, canOverrideSilently: properties.allowsSilentOverride)
            .reduce(into: [BindingKey: AnyBinding]()) { dict, entry in
                try checkOverrideRules(for: entry, beingAddedTo: dict)
                dict[entry.key] = entry.binding
            }
    }

    private func checkOverrideRules(for entry: BindingEntry, beingAddedTo dict: [BindingKey: AnyBinding]) throws {
        if !entry.canOverride, entry.overrides {
            throw OverrideNotAllowed()
        }
        if dict[entry.key] == nil, entry.overrides {
            throw NothingToOverride()
        }
        if dict[entry.key] != nil, !entry.overrides, !entry.canOverrideSilently {
            throw SilentOverrideNotAllowed()
        }
    }

    private func collectBindingEntries(
        from tree: SwinjectTree,
        canOverride: Bool? = nil,
        canOverrideSilently: Bool
    ) -> [BindingEntry] {
        return tree.bindings
            .flatMap { binding in binding.keys.map { key in
                BindingEntry(
                    binding: binding,
                    key: key,
                    overrides: binding.overrides,
                    canOverride: canOverride ?? true,
                    canOverrideSilently: canOverrideSilently
                )
            } }
            + tree.modules.flatMap { collectBindingEntries(
                from: $0.module.tree,
                canOverride: canOverride ?? $0.canOverride,
                canOverrideSilently: $0.module.allowsSilentOverride
            ) }
    }
}

private extension Array where Element: Hashable {
    var containsDuplicates: Bool {
        return count != Set(self).count
    }
}
