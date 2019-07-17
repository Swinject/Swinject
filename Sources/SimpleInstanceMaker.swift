//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct SimpleInstanceMaker<Type, Context, Argument>: InstanceMaker {
    public typealias MadeType = Type

    private let builder: (Resolver, Context, Argument) throws -> Type

    init(_ builder: @escaping (Resolver, Context, Argument) throws -> Type) {
        self.builder = builder
    }

    public func makeInstance(arg: Argument, context: Context, resolver: Resolver) throws -> Type {
        try builder(resolver, context, arg)
    }
}
