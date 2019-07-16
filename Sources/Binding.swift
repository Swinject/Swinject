//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// sourcery: AutoMockable
public protocol AnyBinding {
    func instance(arg: Any, context: Any, resolver: Resolver) throws -> Any
}

public protocol Binding: AnyBinding {
    associatedtype BoundType
    associatedtype Argument
    associatedtype Context
    func instance(arg: Argument, context: Context, resolver: Resolver) throws -> BoundType
}

extension Binding where Argument == Void, Context == Any {
    func instance(resolver: Resolver) throws -> BoundType {
        try instance(arg: (), context: (), resolver: resolver)
    }
}

extension Binding where Argument == Void {
    func instance(context: Context, resolver: Resolver) throws -> BoundType {
        try instance(arg: (), context: context, resolver: resolver)
    }
}

extension Binding where Context == Any {
    func instance(arg: Argument, resolver: Resolver) throws -> BoundType {
        try instance(arg: arg, context: (), resolver: resolver)
    }
}

public extension AnyBinding where Self: Binding {
    func instance(arg: Any, context: Any, resolver: Resolver) throws -> Any {
        guard let arg = arg as? Argument, let context = context as? Context else { throw SwinjectError() }
        return try instance(arg: arg, context: context, resolver: resolver) as BoundType
    }
}
