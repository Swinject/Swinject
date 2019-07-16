//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// TODO: More descriptive name
// TODO: Can we make it internal?
public struct SimpleBinding<Type, Context, Argument>: Binding {
    public typealias BoundType = Type

    private let builder: (Resolver, Context, Argument) throws -> Type

    init(_ builder: @escaping (Resolver, Context, Argument) throws -> Type) {
        self.builder = builder
    }

    public func instance(arg: Argument, context: Context, resolver: Resolver) throws -> Type {
        try builder(resolver, context, arg)
    }
}
