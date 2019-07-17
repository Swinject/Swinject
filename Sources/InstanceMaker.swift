//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// sourcery: AutoMockable
public protocol AnyInstanceMaker {
    func makeInstance(arg: Any, context: Any, resolver: Resolver) throws -> Any
}

public protocol InstanceMaker: AnyInstanceMaker {
    associatedtype MadeType
    associatedtype Argument
    associatedtype Context
    func makeInstance(arg: Argument, context: Context, resolver: Resolver) throws -> MadeType
}

extension InstanceMaker where Argument == Void, Context == Any {
    func makeInstance(resolver: Resolver) throws -> MadeType {
        try makeInstance(arg: (), context: (), resolver: resolver)
    }
}

extension InstanceMaker where Argument == Void {
    func makeInstance(context: Context, resolver: Resolver) throws -> MadeType {
        try makeInstance(arg: (), context: context, resolver: resolver)
    }
}

extension InstanceMaker where Context == Any {
    func makeInstance(arg: Argument, resolver: Resolver) throws -> MadeType {
        try makeInstance(arg: arg, context: (), resolver: resolver)
    }
}

public extension AnyInstanceMaker where Self: InstanceMaker {
    func makeInstance(arg: Any, context: Any, resolver: Resolver) throws -> Any {
        guard let arg = arg as? Argument, let context = context as? Context else { throw SwinjectError() }
        return try makeInstance(arg: arg, context: context, resolver: resolver) as MadeType
    }
}
