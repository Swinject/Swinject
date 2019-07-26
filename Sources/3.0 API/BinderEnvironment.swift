//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct BinderEnvironment<AScope, Context> {
    let scope: AScope
}

public func contexted<Context>(_: Context.Type = Context.self) -> BinderEnvironment<Void, Context> {
    BinderEnvironment(scope: ())
}

public func scoped<AScope>(_ scope: AScope) -> BinderEnvironment<AScope, AScope.Context> where AScope: Scope {
    BinderEnvironment(scope: scope)
}

// swiftlint:disable large_tuple
// swiftlint:disable line_length
// swiftlint:disable identifier_name
public extension BinderEnvironment where AScope == Void {
    func provider<Type>(_ builder: @escaping (Resolver, Context) throws -> Type) -> SimpleBinding.Builder<Type, Context, Void> {
        .init { r, c, _ in try builder(r, c) }
    }
}

public extension BinderEnvironment where AScope == Void {
    func factory<Type, Arg1>(_ builder: @escaping (Resolver, Context, Arg1) throws -> Type) -> SimpleBinding.Builder<Type, Context, Arg1> {
        .init(builder)
    }

    func factory<Type, Arg1, Arg2>(_ builder: @escaping (Resolver, Context, Arg1, Arg2) throws -> Type) -> SimpleBinding.Builder<Type, Context, (Arg1, Arg2)> {
        .init { try builder($0, $1, $2.0, $2.1) }
    }

    func factory<Type, Arg1, Arg2, Arg3>(_ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3) throws -> Type) -> SimpleBinding.Builder<Type, Context, (Arg1, Arg2, Arg3)> {
        .init { try builder($0, $1, $2.0, $2.1, $2.2) }
    }

    func factory<Type, Arg1, Arg2, Arg3, Arg4>(_ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3, Arg4) throws -> Type) -> SimpleBinding.Builder<Type, Context, (Arg1, Arg2, Arg3, Arg4)> {
        .init { try builder($0, $1, $2.0, $2.1, $2.2, $2.3) }
    }

    func factory<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(_ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3, Arg4, Arg5) throws -> Type) -> SimpleBinding.Builder<Type, Context, (Arg1, Arg2, Arg3, Arg4, Arg5)> {
        .init { try builder($0, $1, $2.0, $2.1, $2.2, $2.3, $2.4) }
    }
}

public extension BinderEnvironment where AScope: Scope, Context == AScope.Context {
    func singleton<Type>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping () throws -> Type) -> ScopedBinding.Builder<Type, AScope, Void> {
        .init(scope, ref) { _, _, _ in try builder() }
    }

    func singleton<Type>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver) throws -> Type) -> ScopedBinding.Builder<Type, AScope, Void> {
        .init(scope, ref) { r, _, _ in try builder(r) }
    }

    func singleton<Type>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Context) throws -> Type) -> ScopedBinding.Builder<Type, AScope, Void> {
        .init(scope, ref) { r, c, _ in try builder(r, c) }
    }
}

public extension BinderEnvironment where AScope: Scope, Context == AScope.Context {
    func multiton<Type, Arg1>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Context, Arg1) throws -> Type) -> ScopedBinding.Builder<Type, AScope, Arg1> {
        .init(scope, ref, builder)
    }

    func multiton<Type, Arg1, Arg2>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Context, Arg1, Arg2) throws -> Type) -> ScopedBinding.Builder<Type, AScope, (Arg1, Arg2)> {
        .init(scope, ref) { try builder($0, $1, $2.0, $2.1) }
    }

    func multiton<Type, Arg1, Arg2, Arg3>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3) throws -> Type) -> ScopedBinding.Builder<Type, AScope, (Arg1, Arg2, Arg3)> {
        .init(scope, ref) { try builder($0, $1, $2.0, $2.1, $2.2) }
    }

    func multiton<Type, Arg1, Arg2, Arg3, Arg4>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3, Arg4) throws -> Type) -> ScopedBinding.Builder<Type, AScope, (Arg1, Arg2, Arg3, Arg4)> {
        .init(scope, ref) { try builder($0, $1, $2.0, $2.1, $2.2, $2.3) }
    }

    func multiton<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3, Arg4, Arg5) throws -> Type) -> ScopedBinding.Builder<Type, AScope, (Arg1, Arg2, Arg3, Arg4, Arg5)> {
        .init(scope, ref) { try builder($0, $1, $2.0, $2.1, $2.2, $2.3, $2.4) }
    }
}

public func instance<Type>(_ instance: Type) -> SimpleBinding.Builder<Type, Any, Void> {
    .init { _, _, _ in instance }
}

public func provider<Type>(_ builder: @escaping () throws -> Type) -> SimpleBinding.Builder<Type, Any, Void> {
    .init { _, _, _ in try builder() }
}

public func provider<Type>(_ builder: @escaping (Resolver) throws -> Type) -> SimpleBinding.Builder<Type, Any, Void> {
    .init { r, _, _ in try builder(r) }
}

public func factory<Type, Arg1>(_ builder: @escaping (Resolver, Arg1) throws -> Type) -> SimpleBinding.Builder<Type, Any, Arg1> {
    .init { try builder($0, $2) }
}

public func factory<Type, Arg1: Hashable>(_ builder: @escaping (Resolver, Arg1) throws -> Type) -> SimpleBinding.Builder<Type, Any, ArgumentBox1<Arg1>> {
    .init { try builder($0, $2.arg1) }
}

public func factory<Type, Arg1, Arg2>(_ builder: @escaping (Resolver, Arg1, Arg2) throws -> Type) -> SimpleBinding.Builder<Type, Any, (Arg1, Arg2)> {
    .init { try builder($0, $2.0, $2.1) }
}

public func factory<Type, Arg1, Arg2, Arg3>(_ builder: @escaping (Resolver, Arg1, Arg2, Arg3) throws -> Type) -> SimpleBinding.Builder<Type, Any, (Arg1, Arg2, Arg3)> {
    .init { try builder($0, $2.0, $2.1, $2.2) }
}

public func factory<Type, Arg1, Arg2, Arg3, Arg4>(_ builder: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4) throws -> Type) -> SimpleBinding.Builder<Type, Any, (Arg1, Arg2, Arg3, Arg4)> {
    SimpleBinding.Builder { try builder($0, $2.0, $2.1, $2.2, $2.3) }
}

public func factory<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(_ builder: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4, Arg5) throws -> Type) -> SimpleBinding.Builder<Type, Any, (Arg1, Arg2, Arg3, Arg4, Arg5)> {
    SimpleBinding.Builder { try builder($0, $2.0, $2.1, $2.2, $2.3, $2.4) }
}

public func singleton<Type>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping () throws -> Type) -> ScopedBinding.Builder<Type, UnboundScope, Void> {
    .init(.root, ref) { _, _, _ in try builder() }
}

public func singleton<Type>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver) throws -> Type) -> ScopedBinding.Builder<Type, UnboundScope, Void> {
    .init(.root, ref) { r, _, _ in try builder(r) }
}

public func multiton<Type, Arg1>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Arg1) throws -> Type) -> ScopedBinding.Builder<Type, UnboundScope, Arg1> {
    .init(.root, ref) { try builder($0, $2) }
}

public func multiton<Type, Arg1: Hashable>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Arg1) throws -> Type) -> ScopedBinding.Builder<Type, UnboundScope, ArgumentBox1<Arg1>> {
    .init(.root, ref) { try builder($0, $2.arg1) }
}

public func multiton<Type, Arg1, Arg2>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Arg1, Arg2) throws -> Type) -> ScopedBinding.Builder<Type, UnboundScope, (Arg1, Arg2)> {
    .init(.root, ref) { try builder($0, $2.0, $2.1) }
}

public func multiton<Type, Arg1, Arg2, Arg3>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Arg1, Arg2, Arg3) throws -> Type) -> ScopedBinding.Builder<Type, UnboundScope, (Arg1, Arg2, Arg3)> {
    .init(.root, ref) { try builder($0, $2.0, $2.1, $2.2) }
}

public func multiton<Type, Arg1, Arg2, Arg3, Arg4>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4) throws -> Type) -> ScopedBinding.Builder<Type, UnboundScope, (Arg1, Arg2, Arg3, Arg4)> {
    .init(.root, ref) { try builder($0, $2.0, $2.1, $2.2, $2.3) }
}

public func multiton<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4, Arg5) throws -> Type) -> ScopedBinding.Builder<Type, UnboundScope, (Arg1, Arg2, Arg3, Arg4, Arg5)> {
    .init(.root, ref) { try builder($0, $2.0, $2.1, $2.2, $2.3, $2.4) }
}
