//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// sourcery: AutoMockable
public protocol AnyBinding {
    func instance(arg: Any, resolver: Resolver) throws -> Any
}

public protocol Binding: AnyBinding {
    associatedtype BoundType
    associatedtype Argument
    func instance(arg: Argument, resolver: Resolver) throws -> BoundType
}

public extension Binding where Argument == Void {
    func instance(resolver: Resolver) throws -> BoundType {
        try instance(arg: (), resolver: resolver)
    }
}

public extension AnyBinding where Self: Binding {
    func instance(arg: Any, resolver: Resolver) throws -> Any {
        guard let arg = arg as? Argument else { throw SwinjectError() }
        return try instance(arg: arg, resolver: resolver) as BoundType
    }
}
