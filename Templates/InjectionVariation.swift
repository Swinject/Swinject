// swiftformat:disable fileHeader
let maxArgs = 5

struct InjectionVariation {
    let isTagged: Bool
    let paramArgs: Int
    let factoryArgs: Int
    let isMatchable: Bool
    var args: Int { return paramArgs + factoryArgs }
}

extension InjectionVariation {
    var genericTypes: String { [
        "Type",
        isTagged ? "Tag" : nil,
        args > 0 ? (1 ... args).map { "Arg\($0)" }.joined(separator: ", ") : nil,
    ].compactMap { $0 }.joined(separator: ", ") }

    var params: String { [
        "of _: Type.Type = Type.self",
        isTagged ? "tagged tag: Tag" : nil,
        paramArgs >= 1 ? "arg " + (1 ... paramArgs).map { "arg\($0): Arg\($0)" }.joined(separator: ", _ ") : nil,
    ].compactMap { $0 }.joined(separator: ", ") }

    var factoryInputs: String {
        (1 ... factoryArgs).map { "Arg\($0 + paramArgs)" }.joined(separator: ", ")
    }

    var constraints: String { [
        isTagged ? "Tag: Hashable" : nil,
        isMatchable && args > 0 ? (1 ... args).map { "Arg\($0): Hashable" }.joined(separator: ", ") : nil,
    ].compactMap { $0 }.joined(separator: ", ") }

    var whereClause: String { constraints.isEmpty ? "" : "where " + constraints }

    var requestParams: String {
        let paramVars = (0 ..< paramArgs).map { "arg\($0 + 1)" }
        let factoryVars = (0 ..< factoryArgs).map { "$\($0)" }
        return [
            isTagged ? "tag: tag" : "tag: NoTag()",
            args == 0 ? "arg: ()" : "arg: box(\((paramVars + factoryVars).joined(separator: ", ")))",
        ].compactMap { $0 }.joined(separator: ", ")
    }
}

extension InjectionVariation {
    static let simpleCases = (0 ... maxArgs)
        .flatMap { a in [false, true].map { ($0, a) } }
        .flatMap { t in [false, true].map { (t.0, t.1, 0, $0) } }
        .map { InjectionVariation(isTagged: $0.0, paramArgs: $0.1, factoryArgs: $0.2, isMatchable: $0.3) }
        .filter { $0.paramArgs > 0 || $0.isMatchable }

    static let factoryCases = (1 ... maxArgs)
        .flatMap { a in [false, true].map { ($0, a) } }
        .flatMap { t in [false, true].map { (t.0, t.1, $0) } }
        .flatMap { t in (0 ..< t.1).map { (t.0, $0, t.1 - $0, t.2) } }
        .map { InjectionVariation(isTagged: $0.0, paramArgs: $0.1, factoryArgs: $0.2, isMatchable: $0.3) }
}
