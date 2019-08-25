//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

struct InstanceRequestVariation {
    let args: Int
    let isMatchable: Bool
}

extension InstanceRequestVariation {
    var genericTypes: String {
        return join(
            "Type",
            args > 0 ? join((1 ... args).map { "Arg\($0)" }) : nil
        )
    }

    var params: String {
        return join(
            "of _: Type.Type = Type.self",
            "tagged tag: String? = nil",
            args >= 1 ? "arg " + join(separator: ", _ ", (1 ... args).map { "arg\($0): Arg\($0)" }) : nil
        )
    }

    var constraints: String {
        return join(
            isMatchable && args > 0 ? join((1 ... args).map { "Arg\($0): Hashable" }) : nil
        )
    }

    var whereClause: String? {
        return constraints.isEmpty ? nil : "where " + constraints
    }

    var requestParams: String {
        let argVars = join((0 ..< args).map { "arg\($0 + 1)" })
        return join(
            "type: Type.self",
            "tag: tag",
            "arg: Arguments(\(argVars))"
        )
    }

    var functionName: String {
        return "instance"
    }

    var returnType: String {
        return "InstanceRequest<Type>"
    }

    var returnDescription: String {
        return join(separator: " ", "->", returnType, whereClause)
    }

    var returnStatement: String {
        return "return request(\(requestParams))"
    }
}

extension InstanceRequestVariation {
    static let maxArgs = 5

    static let allCases = (0 ... maxArgs)
        .flatMap { t in [false, true].map { (t, $0) } }
        .map(InstanceRequestVariation.init)

    static let sortedCases = allCases.sorted { [
        $0.args < $1.args,
        !$0.isMatchable && $1.isMatchable && $0.args == $1.args,
    ].contains(true) }

    static let publicCases = sortedCases
        .filter { !($0.args == 0 && !$0.isMatchable) }
}

extension InstanceRequestVariation {
    func render() -> String {
        return """
        public func \(functionName)<\(genericTypes)>(\(params)) \(returnDescription) {
            \(returnStatement)
        }
        """
    }
}
