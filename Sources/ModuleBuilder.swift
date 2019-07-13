//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public protocol ModuleEntry {}

@_functionBuilder
public enum ModuleBuilder {
    public typealias Entry = ModuleEntry

    public static func buildBlock(_ input: Entry ...) -> [Entry] {
        input.flatMap(unpack)
    }

    public static func buildIf(_ input: [Entry]?) -> Entry {
        Composed(parts: input ?? [])
    }

    public static func buildEither(first input: [Entry]) -> Entry {
        Composed(parts: input)
    }

    public static func buildEither(second input: [Entry]) -> Entry {
        Composed(parts: input)
    }

    private struct Composed: Entry {
        let parts: [Entry]
    }

    private static func unpack(entry: Entry) -> [Entry] {
        if let entry = entry as? Composed { return entry.parts } else { return [entry] }
    }
}
