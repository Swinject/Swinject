//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct FactoryBinding<Type, Argument>: Binding {
    public typealias BoundType = Type

    private let builder: (Resolver, Argument) throws -> Type

    init(_ builder: @escaping (Resolver, Argument) throws -> Type) {
        self.builder = builder
    }

    public func instance(arg: Argument, resolver provider: Resolver) throws -> Type {
        try builder(provider, arg)
    }
}

public func factory<Type, Arg1>(_ builder: @escaping (Resolver, Arg1) throws -> Type) -> FactoryBinding<Type, Arg1> {
    FactoryBinding(builder)
}

public func factory<Type, Arg1, Arg2>(_ builder: @escaping (Resolver, Arg1, Arg2) throws -> Type) -> FactoryBinding<Type, (Arg1, Arg2)> {
    FactoryBinding { try builder($0, $1.0, $1.1) }
}

public func factory<Type, Arg1, Arg2, Arg3>(_ builder: @escaping (Resolver, Arg1, Arg2, Arg3) throws -> Type) -> FactoryBinding<Type, (Arg1, Arg2, Arg3)> {
    FactoryBinding { try builder($0, $1.0, $1.1, $1.2) }
}

public func factory<Type, Arg1, Arg2, Arg3, Arg4>(_ builder: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4) throws -> Type) -> FactoryBinding<Type, (Arg1, Arg2, Arg3, Arg4)> {
    FactoryBinding { try builder($0, $1.0, $1.1, $1.2, $1.3) }
}

public func factory<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(_ builder: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4, Arg5) throws -> Type) -> FactoryBinding<Type, (Arg1, Arg2, Arg3, Arg4, Arg5)> {
    FactoryBinding { try builder($0, $1.0, $1.1, $1.2, $1.3, $1.4) }
}
