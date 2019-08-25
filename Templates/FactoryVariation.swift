//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

struct FactoryVariation {
    let args: Int
    let hasResolver: Bool
    let isMatchable: Bool
}

extension FactoryVariation {
    var argTypes: String {
        return join((1 ..< args + 1).map { "Arg\($0)" })
    }

    var argTypesOrNil: String? {
        return argTypes.isEmpty ? nil : argTypes
    }

    var genericTypes: String {
        return join("NewInstance", argTypesOrNil)
    }

    var factoryInputTypes: String {
        return join(
            hasResolver ? "ContextedResolver<Context>" : nil,
            argTypesOrNil
        )
    }

    var params: String {
        return join(
            "for _: NewInstance.Type = NewInstance.self",
            "tag: String? = nil",
            "factory: @escaping (\(factoryInputTypes)) throws -> NewInstance"
        )
    }

    var argDescriptorTypes: String {
        return join((1 ..< args + 1).map { "Arg\($0).self" })
    }

    var returnType: String {
        return "Binding<NewInstance, Context>"
    }

    var hashableArgTypes: String {
        return join((1 ..< args + 1).map { "Arg\($0): Hashable" })
    }

    var constraints: String {
        return isMatchable && args > 0 ? "where \(hashableArgTypes) " : ""
    }

    var argVarsOrNil: String? {
        switch args {
        case 0: return nil
        default: return join((0 ..< args).map { "a.arg(\($0))" })
        }
    }

    var factoryInputs: String {
        return join(
            hasResolver ? "r" : "_",
            args > 0 ? "a" : "_"
        )
    }

    var factoryVars: String {
        return join(
            hasResolver ? "r" : nil,
            argVarsOrNil
        )
    }
}

extension FactoryVariation {
    static let maxArgs = 5

    static let allCases = (0 ... maxArgs)
        .flatMap { t in [false, true].map { (t, $0) } }
        .flatMap { t in [false, true].map { (t.0, t.1, $0) } }
        .map(FactoryVariation.init)

    static let sortedCases = allCases.sorted { [
        $0.args < $1.args,
        !$0.isMatchable && $1.isMatchable && $0.args == $1.args,
    ].contains(true) }

    static let publicCases = sortedCases
        .filter { !($0.args == 0 && !$0.isMatchable) }
        .filter { !($0.args > 0 && !$0.hasResolver) }
}

extension FactoryVariation {
    func render() -> String {
        return """
            func factory<\(genericTypes)>(\(params)) -> \(returnType) \(constraints){
                return updatedFactory { \(factoryInputs) in try factory(\(factoryVars)) }.updated {
                    $0.products = [tagged(NewInstance.self, with: tag)]
                    $0.dependencies = .undefined
                    $0.arguments = [\(argDescriptorTypes)]
                }
            }
        """
    }
}
