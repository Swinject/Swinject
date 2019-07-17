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

public extension BinderEnvironment where AScope == Void {
    func provider<Type>(_ builder: @escaping (Resolver, Context) throws -> Type) -> SimpleInstanceMaker<Type, Context, Void> {
        .init { r, c, _ in try builder(r, c) }
    }

    func factory<Type, Arg1>(_ builder: @escaping (Resolver, Context, Arg1) throws -> Type) -> SimpleInstanceMaker<Type, Context, Arg1> {
        .init(builder)
    }

    func factory<Type, Arg1, Arg2>(_ builder: @escaping (Resolver, Context, Arg1, Arg2) throws -> Type) -> SimpleInstanceMaker<Type, Context, (Arg1, Arg2)> {
        .init { try builder($0, $1, $2.0, $2.1) }
    }

    func factory<Type, Arg1, Arg2, Arg3>(_ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3) throws -> Type) -> SimpleInstanceMaker<Type, Context, (Arg1, Arg2, Arg3)> {
        .init { try builder($0, $1, $2.0, $2.1, $2.2) }
    }

    func factory<Type, Arg1, Arg2, Arg3, Arg4>(_ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3, Arg4) throws -> Type) -> SimpleInstanceMaker<Type, Context, (Arg1, Arg2, Arg3, Arg4)> {
        .init { try builder($0, $1, $2.0, $2.1, $2.2, $2.3) }
    }

    func factory<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(_ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3, Arg4, Arg5) throws -> Type) -> SimpleInstanceMaker<Type, Context, (Arg1, Arg2, Arg3, Arg4, Arg5)> {
        .init { try builder($0, $1, $2.0, $2.1, $2.2, $2.3, $2.4) }
    }
}

public func instance<Type>(_ instance: Type) -> SimpleInstanceMaker<Type, Any, Void> {
    .init { _, _, _ in instance }
}

public func provider<Type>(_ builder: @escaping () throws -> Type) -> SimpleInstanceMaker<Type, Any, Void> {
    .init { _, _, _ in try builder() }
}

public func provider<Type>(_ builder: @escaping (Resolver) throws -> Type) -> SimpleInstanceMaker<Type, Any, Void> {
    .init { r, _, _ in try builder(r) }
}

public func factory<Type, Arg1>(_ builder: @escaping (Resolver, Arg1) throws -> Type) -> SimpleInstanceMaker<Type, Any, Arg1> {
    .init { try builder($0, $2) }
}

public func factory<Type, Arg1, Arg2>(_ builder: @escaping (Resolver, Arg1, Arg2) throws -> Type) -> SimpleInstanceMaker<Type, Any, (Arg1, Arg2)> {
    .init { try builder($0, $2.0, $2.1) }
}

public func factory<Type, Arg1, Arg2, Arg3>(_ builder: @escaping (Resolver, Arg1, Arg2, Arg3) throws -> Type) -> SimpleInstanceMaker<Type, Any, (Arg1, Arg2, Arg3)> {
    .init { try builder($0, $2.0, $2.1, $2.2) }
}

public func factory<Type, Arg1, Arg2, Arg3, Arg4>(_ builder: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4) throws -> Type) -> SimpleInstanceMaker<Type, Any, (Arg1, Arg2, Arg3, Arg4)> {
    SimpleInstanceMaker { try builder($0, $2.0, $2.1, $2.2, $2.3) }
}

public func factory<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(_ builder: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4, Arg5) throws -> Type) -> SimpleInstanceMaker<Type, Any, (Arg1, Arg2, Arg3, Arg4, Arg5)> {
    SimpleInstanceMaker { try builder($0, $2.0, $2.1, $2.2, $2.3, $2.4) }
}
