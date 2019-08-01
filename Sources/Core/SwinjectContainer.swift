//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

struct SwinjectContainer {
    let bindings: [BindingKey: Binding]
    let translators: [AnyContextTranslator]

    struct Builder {
        let tree: SwinjectTree
        let allowsSilentOverride: Bool
    }
}

extension SwinjectContainer.Builder {
    func makeContainer() -> SwinjectContainer {
        do { return try makeContainerOrThrow() } catch { fatalError("\(error)") }
    }

    private func makeContainerOrThrow() throws -> SwinjectContainer {
        try checkDuplicitModules()
        return try SwinjectContainer(
            bindings: collectBindings(),
            translators: tree.translators
        )
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
        let binding: Binding
        let key: BindingKey
        let properties: BindingProperties
        let canOverride: Bool
        let canOverrideSilently: Bool
    }

    private func collectBindings() throws -> [BindingKey: Binding] {
        return try collectBindingEntries(from: tree, canOverrideSilently: allowsSilentOverride)
            .reduce(into: [BindingKey: Binding]()) { dict, entry in
                try checkOverrideRules(for: entry, beingAddedTo: dict)
                dict[entry.key] = entry.binding
            }
    }

    private func checkOverrideRules(for entry: BindingEntry, beingAddedTo dict: [BindingKey: Binding]) throws {
        if !entry.canOverride, entry.properties.overrides {
            throw OverrideNotAllowed()
        }
        if dict[entry.key] == nil, entry.properties.overrides {
            throw NothingToOverride()
        }
        if dict[entry.key] != nil, !entry.properties.overrides, !entry.canOverrideSilently {
            throw SilentOverrideNotAllowed()
        }
    }

    private func collectBindingEntries(
        from tree: SwinjectTree,
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
