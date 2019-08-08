//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct SwinjectTree {
    let bindings: [Binding]
    let modules: [ModuleInclusion]
    let translators: [AnyContextTranslator]
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
        return SwinjectTree(
            bindings: entries.compactMap { $0 as? AnyBindingBuilder }.map { $0.makeBinding() },
            modules: entries.compactMap { $0 as? ModuleInclusion },
            translators: entries.compactMap { $0 as? AnyContextTranslator }
        )
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
