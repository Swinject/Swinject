//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// TODO: More descriptive name
// TODO: Can we make it internal?
public struct SimpleBinding<Type, Argument>: Binding {
    public typealias BoundType = Type

    private let builder: (Resolver, Argument) throws -> Type

    init(_ builder: @escaping (Resolver, Argument) throws -> Type) {
        self.builder = builder
    }

    public func instance(arg: Argument, context _: Void, resolver: Resolver) throws -> Type {
        try builder(resolver, arg)
    }
}
