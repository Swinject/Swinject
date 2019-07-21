//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// sourcery: AutoMockable
public protocol AnyInstanceMaker {
    func makeInstance(arg: Any, context: Any, resolver: Resolver) throws -> Any
}

// FIXME: "Maker" is not a typical concept
// Could we use `InstanceFactory` / `InstanceBuilder` instead, or would it be too overloaded?
public protocol InstanceMaker: AnyInstanceMaker {
    associatedtype MadeType
    associatedtype Argument
    associatedtype Context
    func makeInstance(arg: Argument, context: Context, resolver: Resolver) throws -> MadeType
}

public extension InstanceMaker {
    func makeInstance(arg: Any, context: Any, resolver: Resolver) throws -> Any {
        guard let arg = arg as? Argument, let context = context as? Context else { throw SwinjectError() }
        return try makeInstance(arg: arg, context: context, resolver: resolver) as MadeType
    }
}
