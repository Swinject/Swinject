//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

struct InjectionVariation {
    let paramArgs: Int
    let factoryArgs: Int
    let isTagged: Bool
    let isMatchable: Bool
    let isDelayed: Bool
}

extension InjectionVariation {
    var args: Int { return paramArgs + factoryArgs }

    var genericTypes: String {
        return join(
            "Type",
            isTagged ? "Tag" : nil,
            args > 0 ? join((1 ... args).map { "Arg\($0)" }) : nil
        )
    }

    var params: String {
        return join(
            "of _: Type.Type = Type.self",
            isTagged ? "tagged tag: Tag" : nil,
            paramArgs >= 1 ? "arg " + join(separator: ", _ ", (1 ... paramArgs).map { "arg\($0): Arg\($0)" }) : nil
        )
    }

    var factoryInputs: String {
        return join((1 ..< factoryArgs + 1).map { "Arg\($0 + paramArgs)" })
    }

    var constraints: String {
        return join(
            isTagged ? "Tag: Hashable" : nil,
            isMatchable && args > 0 ? join((1 ... args).map { "Arg\($0): Hashable" }) : nil
        )
    }

    var whereClause: String? {
        return constraints.isEmpty ? nil : "where " + constraints
    }

    var requestParams: String {
        let paramVars = (0 ..< paramArgs).map { "arg\($0 + 1)" }
        let factoryVars = (0 ..< factoryArgs).map { "$\($0)" }
        return join(
            "type: Type.self",
            isTagged ? "tag: tag" : "tag: NoTag()",
            args == 0 ? "arg: ()" : "arg: box(\(join(paramVars + factoryVars)))"
        )
    }

    var functionName: String {
        if !isDelayed { return "instance" }
        else if factoryArgs == 0 { return "provider" }
        else { return "factory" }
    }

    var returnType: String {
        if !isDelayed {
            return "throws -> Type"
        } else {
            return "-> (\(factoryInputs)) throws -> Type"
        }
    }

    var returnDescription: String {
        return join(separator: " ", returnType, whereClause)
    }

    var returnStatement: String {
        if isDelayed {
            return "return { try self.resolve(request(\(requestParams))) }"
        } else {
            return "return try resolve(request(\(requestParams)))"
        }
    }
}

extension InjectionVariation {
    static let maxArgs = 5

    static let allCases = (0 ... maxArgs)
        .flatMap { t in (t ... maxArgs).map { (t, maxArgs - $0) } }
        .flatMap { t in [false, true].map { (t.0, t.1, $0) } }
        .flatMap { t in [false, true].map { (t.0, t.1, t.2, $0) } }
        .flatMap { t in [false, true].map { (t.0, t.1, t.2, t.3, $0) } }
        .map(InjectionVariation.init)

    static let sortedCases = allCases.sorted { [
        $0.args < $1.args,
        !$0.isTagged && $1.isTagged && $0.args == $1.args,
        !$0.isMatchable && $1.isMatchable && $0.args == $1.args && $0.isTagged == $1.isTagged,
    ].contains(true) }

    static let publicCases = sortedCases
        .filter { !($0.args == 0 && !$0.isMatchable) }
        .filter { !($0.factoryArgs > 0 && !$0.isDelayed) }
}

extension InjectionVariation {
    func render() -> String {
        return """
            func \(functionName)<\(genericTypes)>(\(params)) \(returnDescription) {
                \(returnStatement)
            }
        """
    }
}
