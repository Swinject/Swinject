//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct SwinjectTree {
    let bindings: [Binding]
    let modules: [Swinject.Module]
    let translators: [AnyContextTranslator]
}

extension SwinjectTree {
    var allBindings: [Binding] {
        return bindings + modules.flatMap { $0.tree.allBindings }
    }

    var allModules: [Swinject.Module] {
        return modules + modules.flatMap { $0.tree.allModules }
    }
}

extension SwinjectTree {
    func assertValid() {
        let allModuleNames = allModules.map { $0.name }
        assert(allModuleNames.count == Set(allModuleNames).count)
        assert(allBindings.count == Set(allBindings.map { $0.key }).count)
    }
}

#if swift(>=5.1)
    @_functionBuilder
    public enum SwinjectTreeBuilder {}
#else
    public enum SwinjectTreeBuilder {}
#endif

public protocol SwinjectEntry {}

extension SwinjectTreeBuilder {
    public static func buildBlock() {}

    public static func buildBlock(_ input: SwinjectEntry ...) -> [SwinjectEntry] {
        return input.flatMap(unpack)
    }

    public static func buildIf(_ input: [SwinjectEntry]?) -> SwinjectEntry {
        return Composed(parts: input ?? [])
    }

    public static func buildEither(first input: [SwinjectEntry]) -> SwinjectEntry {
        return Composed(parts: input)
    }

    public static func buildEither(second input: [SwinjectEntry]) -> SwinjectEntry {
        return Composed(parts: input)
    }

    // This is not used by compiler implicitly yet
    public static func buildFunction(_ input: [SwinjectEntry]) -> SwinjectTree {
        let entries = input.flatMap(unpack)
        let tree = SwinjectTree(
            bindings: entries.compactMap { $0 as? Binding },
            modules: entries.compactMap { $0 as? Swinject.Module },
            translators: entries.compactMap { $0 as? AnyContextTranslator }
        )
        tree.assertValid()
        return tree
    }
}

extension SwinjectTreeBuilder {
    private struct Composed: SwinjectEntry {
        let parts: [SwinjectEntry]
    }

    private static func unpack(entry: SwinjectEntry) -> [SwinjectEntry] {
        if let entry = entry as? Composed { return entry.parts } else { return [entry] }
    }
}
