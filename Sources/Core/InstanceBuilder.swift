//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

protocol AnyInstanceBuilder {
    func makeInstance(arg: Any, context: Any, resolver: Resolver) throws -> Any
}

protocol InstanceBuilder: AnyInstanceBuilder {
    associatedtype MadeType
    associatedtype Argument
    associatedtype Context
    func makeInstance(arg: Argument, context: Context, resolver: Resolver) throws -> MadeType
}

extension InstanceBuilder {
    func makeInstance(arg: Any, context: Any, resolver: Resolver) throws -> Any {
        guard let arg = arg as? Argument, let context = context as? Context else { throw SwinjectError() }
        return try makeInstance(arg: arg, context: context, resolver: resolver) as MadeType
    }
}
