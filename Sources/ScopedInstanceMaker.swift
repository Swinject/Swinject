//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// FIXME: AScope is suboptimal name for a parameter
// Can we rename Scope -> ScopeProtocol?
public struct ScopedInstanceMaker<Type, AScope, Argument>: InstanceMaker where AScope: Scope {
    public typealias MadeType = Type
    public typealias Context = AScope.Context

    let scope: AScope
    private let builder: (Resolver, Context, Argument) throws -> Type

    init(_ scope: AScope, _ builder: @escaping (Resolver, Context, Argument) throws -> Type) {
        self.scope = scope
        self.builder = builder
    }

    public func makeInstance(arg: Argument, context: Context, resolver: Resolver) throws -> Type {
        try builder(resolver, context, arg)
    }
}

public extension BinderEnvironment where AScope: Scope, Context == AScope.Context {
    func singleton<Type>(_ builder: @escaping () throws -> Type) -> ScopedInstanceMaker<Type, AScope, Void> {
        .init(scope) { _, _, _ in try builder() }
    }

    func singleton<Type>(_ builder: @escaping (Resolver) throws -> Type) -> ScopedInstanceMaker<Type, AScope, Void> {
        .init(scope) { r, _, _ in try builder(r) }
    }

    func singleton<Type>(_ builder: @escaping (Resolver, Context) throws -> Type) -> ScopedInstanceMaker<Type, AScope, Void> {
        .init(scope) { r, c, _ in try builder(r, c) }
    }

    func multiton<Type, Arg1>(_ builder: @escaping (Resolver, Context, Arg1) throws -> Type) -> ScopedInstanceMaker<Type, AScope, Arg1> {
        .init(scope, builder)
    }

    func multiton<Type, Arg1, Arg2>(_ builder: @escaping (Resolver, Context, Arg1, Arg2) throws -> Type) -> ScopedInstanceMaker<Type, AScope, (Arg1, Arg2)> {
        .init(scope) { try builder($0, $1, $2.0, $2.1) }
    }

    func multiton<Type, Arg1, Arg2, Arg3>(_ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3) throws -> Type) -> ScopedInstanceMaker<Type, AScope, (Arg1, Arg2, Arg3)> {
        .init(scope) { try builder($0, $1, $2.0, $2.1, $2.2) }
    }

    func multiton<Type, Arg1, Arg2, Arg3, Arg4>(_ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3, Arg4) throws -> Type) -> ScopedInstanceMaker<Type, AScope, (Arg1, Arg2, Arg3, Arg4)> {
        .init(scope) { try builder($0, $1, $2.0, $2.1, $2.2, $2.3) }
    }

    func multiton<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(_ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3, Arg4, Arg5) throws -> Type) -> ScopedInstanceMaker<Type, AScope, (Arg1, Arg2, Arg3, Arg4, Arg5)> {
        .init(scope) { try builder($0, $1, $2.0, $2.1, $2.2, $2.3, $2.4) }
    }
}

public func singleton<Type>(_ builder: @escaping () throws -> Type) -> ScopedInstanceMaker<Type, ImplicitScope, Void> {
    .init(.implicit) { _, _, _ in try builder() }
}

public func singleton<Type>(_ builder: @escaping (Resolver) throws -> Type) -> ScopedInstanceMaker<Type, ImplicitScope, Void> {
    .init(.implicit) { r, _, _ in try builder(r) }
}

public func multiton<Type, Arg1>(_ builder: @escaping (Resolver, Arg1) throws -> Type) -> ScopedInstanceMaker<Type, ImplicitScope, Arg1> {
    .init(.implicit) { try builder($0, $2) }
}

public func multiton<Type, Arg1, Arg2>(_ builder: @escaping (Resolver, Arg1, Arg2) throws -> Type) -> ScopedInstanceMaker<Type, ImplicitScope, (Arg1, Arg2)> {
    .init(.implicit) { try builder($0, $2.0, $2.1) }
}

public func multiton<Type, Arg1, Arg2, Arg3>(_ builder: @escaping (Resolver, Arg1, Arg2, Arg3) throws -> Type) -> ScopedInstanceMaker<Type, ImplicitScope, (Arg1, Arg2, Arg3)> {
    .init(.implicit) { try builder($0, $2.0, $2.1, $2.2) }
}

public func multiton<Type, Arg1, Arg2, Arg3, Arg4>(_ builder: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4) throws -> Type) -> ScopedInstanceMaker<Type, ImplicitScope, (Arg1, Arg2, Arg3, Arg4)> {
    .init(.implicit) { try builder($0, $2.0, $2.1, $2.2, $2.3) }
}

public func multiton<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(_ builder: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4, Arg5) throws -> Type) -> ScopedInstanceMaker<Type, ImplicitScope, (Arg1, Arg2, Arg3, Arg4, Arg5)> {
    .init(.implicit) { try builder($0, $2.0, $2.1, $2.2, $2.3, $2.4) }
}
