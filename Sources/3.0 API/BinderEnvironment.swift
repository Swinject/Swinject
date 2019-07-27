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

public func instance<Type>(_ instance: Type) -> SimpleBinding.Builder<Type, Any, Void> {
    .init { _, _, _ in instance }
}

// sourcery:inline:BindingBuilders
extension BinderEnvironment where AScope == Void {
    public func provider<Type>(_ builder: @escaping () throws -> Type) -> SimpleBinding.Builder<Type, Context, Void> {
        .init { _, _, _ in try builder() }
    }

    public func provider<Type>(_ builder: @escaping (Resolver) throws -> Type) -> SimpleBinding.Builder<Type, Context, Void> {
        .init { r, _, _ in try builder(r) }
    }

    public func provider<Type>(_ builder: @escaping (Resolver, Context) throws -> Type) -> SimpleBinding.Builder<Type, Context, Void> {
        .init { r, c, _ in try builder(r, c) }
    }

    public func factory<Type, Arg1>(_ builder: @escaping (Resolver, Context, Arg1) throws -> Type) -> SimpleBinding.Builder<Type, Context, Arg1> {
        .init { r, c, a in try builder(r, c, a) }
    }

    public func factory<Type, Arg1>(_ builder: @escaping (Resolver, Context, Arg1) throws -> Type) -> SimpleBinding.Builder<Type, Context, MatchableBox1<Arg1>> where Arg1: Hashable {
        .init { r, c, a in try builder(r, c, a.arg1) }
    }

    public func factory<Type, Arg1, Arg2>(_ builder: @escaping (Resolver, Context, Arg1, Arg2) throws -> Type) -> SimpleBinding.Builder<Type, Context, (Arg1, Arg2)> {
        .init { r, c, a in try builder(r, c, a.0, a.1) }
    }

    public func factory<Type, Arg1, Arg2>(_ builder: @escaping (Resolver, Context, Arg1, Arg2) throws -> Type) -> SimpleBinding.Builder<Type, Context, MatchableBox2<Arg1, Arg2>> where Arg1: Hashable, Arg2: Hashable {
        .init { r, c, a in try builder(r, c, a.arg1, a.arg2) }
    }

    public func factory<Type, Arg1, Arg2, Arg3>(_ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3) throws -> Type) -> SimpleBinding.Builder<Type, Context, (Arg1, Arg2, Arg3)> {
        .init { r, c, a in try builder(r, c, a.0, a.1, a.2) }
    }

    public func factory<Type, Arg1, Arg2, Arg3>(_ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3) throws -> Type) -> SimpleBinding.Builder<Type, Context, MatchableBox3<Arg1, Arg2, Arg3>> where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable {
        .init { r, c, a in try builder(r, c, a.arg1, a.arg2, a.arg3) }
    }

    public func factory<Type, Arg1, Arg2, Arg3, Arg4>(_ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3, Arg4) throws -> Type) -> SimpleBinding.Builder<Type, Context, (Arg1, Arg2, Arg3, Arg4)> {
        .init { r, c, a in try builder(r, c, a.0, a.1, a.2, a.3) }
    }

    public func factory<Type, Arg1, Arg2, Arg3, Arg4>(_ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3, Arg4) throws -> Type) -> SimpleBinding.Builder<Type, Context, MatchableBox4<Arg1, Arg2, Arg3, Arg4>> where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable {
        .init { r, c, a in try builder(r, c, a.arg1, a.arg2, a.arg3, a.arg4) }
    }

    public func factory<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(_ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3, Arg4, Arg5) throws -> Type) -> SimpleBinding.Builder<Type, Context, (Arg1, Arg2, Arg3, Arg4, Arg5)> {
        .init { r, c, a in try builder(r, c, a.0, a.1, a.2, a.3, a.4) }
    }

    public func factory<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(_ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3, Arg4, Arg5) throws -> Type) -> SimpleBinding.Builder<Type, Context, MatchableBox5<Arg1, Arg2, Arg3, Arg4, Arg5>> where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable, Arg5: Hashable {
        .init { r, c, a in try builder(r, c, a.arg1, a.arg2, a.arg3, a.arg4, a.arg5) }
    }
}

extension BinderEnvironment where AScope: Scope, Context == AScope.Context {
    public func singleton<Type>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping () throws -> Type) -> ScopedBinding.Builder<Type, AScope, Void> {
        .init(scope, ref) { _, _, _ in try builder() }
    }

    public func singleton<Type>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver) throws -> Type) -> ScopedBinding.Builder<Type, AScope, Void> {
        .init(scope, ref) { r, _, _ in try builder(r) }
    }

    public func singleton<Type>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Context) throws -> Type) -> ScopedBinding.Builder<Type, AScope, Void> {
        .init(scope, ref) { r, c, _ in try builder(r, c) }
    }

    public func multiton<Type, Arg1>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Context, Arg1) throws -> Type) -> ScopedBinding.Builder<Type, AScope, Arg1> {
        .init(scope, ref) { r, c, a in try builder(r, c, a) }
    }

    public func multiton<Type, Arg1>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Context, Arg1) throws -> Type) -> ScopedBinding.Builder<Type, AScope, MatchableBox1<Arg1>> where Arg1: Hashable {
        .init(scope, ref) { r, c, a in try builder(r, c, a.arg1) }
    }

    public func multiton<Type, Arg1, Arg2>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Context, Arg1, Arg2) throws -> Type) -> ScopedBinding.Builder<Type, AScope, (Arg1, Arg2)> {
        .init(scope, ref) { r, c, a in try builder(r, c, a.0, a.1) }
    }

    public func multiton<Type, Arg1, Arg2>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Context, Arg1, Arg2) throws -> Type) -> ScopedBinding.Builder<Type, AScope, MatchableBox2<Arg1, Arg2>> where Arg1: Hashable, Arg2: Hashable {
        .init(scope, ref) { r, c, a in try builder(r, c, a.arg1, a.arg2) }
    }

    public func multiton<Type, Arg1, Arg2, Arg3>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3) throws -> Type) -> ScopedBinding.Builder<Type, AScope, (Arg1, Arg2, Arg3)> {
        .init(scope, ref) { r, c, a in try builder(r, c, a.0, a.1, a.2) }
    }

    public func multiton<Type, Arg1, Arg2, Arg3>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3) throws -> Type) -> ScopedBinding.Builder<Type, AScope, MatchableBox3<Arg1, Arg2, Arg3>> where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable {
        .init(scope, ref) { r, c, a in try builder(r, c, a.arg1, a.arg2, a.arg3) }
    }

    public func multiton<Type, Arg1, Arg2, Arg3, Arg4>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3, Arg4) throws -> Type) -> ScopedBinding.Builder<Type, AScope, (Arg1, Arg2, Arg3, Arg4)> {
        .init(scope, ref) { r, c, a in try builder(r, c, a.0, a.1, a.2, a.3) }
    }

    public func multiton<Type, Arg1, Arg2, Arg3, Arg4>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3, Arg4) throws -> Type) -> ScopedBinding.Builder<Type, AScope, MatchableBox4<Arg1, Arg2, Arg3, Arg4>> where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable {
        .init(scope, ref) { r, c, a in try builder(r, c, a.arg1, a.arg2, a.arg3, a.arg4) }
    }

    public func multiton<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3, Arg4, Arg5) throws -> Type) -> ScopedBinding.Builder<Type, AScope, (Arg1, Arg2, Arg3, Arg4, Arg5)> {
        .init(scope, ref) { r, c, a in try builder(r, c, a.0, a.1, a.2, a.3, a.4) }
    }

    public func multiton<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3, Arg4, Arg5) throws -> Type) -> ScopedBinding.Builder<Type, AScope, MatchableBox5<Arg1, Arg2, Arg3, Arg4, Arg5>> where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable, Arg5: Hashable {
        .init(scope, ref) { r, c, a in try builder(r, c, a.arg1, a.arg2, a.arg3, a.arg4, a.arg5) }
    }
}

public func provider<Type>(_ builder: @escaping () throws -> Type) -> SimpleBinding.Builder<Type, Any, Void> {
    .init { _, _, _ in try builder() }
}

public func provider<Type>(_ builder: @escaping (Resolver) throws -> Type) -> SimpleBinding.Builder<Type, Any, Void> {
    .init { r, _, _ in try builder(r) }
}

public func factory<Type, Arg1>(_ builder: @escaping (Resolver, Arg1) throws -> Type) -> SimpleBinding.Builder<Type, Any, Arg1> {
    .init { r, _, a in try builder(r, a) }
}

public func factory<Type, Arg1>(_ builder: @escaping (Resolver, Arg1) throws -> Type) -> SimpleBinding.Builder<Type, Any, MatchableBox1<Arg1>> where Arg1: Hashable {
    .init { r, _, a in try builder(r, a.arg1) }
}

public func factory<Type, Arg1, Arg2>(_ builder: @escaping (Resolver, Arg1, Arg2) throws -> Type) -> SimpleBinding.Builder<Type, Any, (Arg1, Arg2)> {
    .init { r, _, a in try builder(r, a.0, a.1) }
}

public func factory<Type, Arg1, Arg2>(_ builder: @escaping (Resolver, Arg1, Arg2) throws -> Type) -> SimpleBinding.Builder<Type, Any, MatchableBox2<Arg1, Arg2>> where Arg1: Hashable, Arg2: Hashable {
    .init { r, _, a in try builder(r, a.arg1, a.arg2) }
}

public func factory<Type, Arg1, Arg2, Arg3>(_ builder: @escaping (Resolver, Arg1, Arg2, Arg3) throws -> Type) -> SimpleBinding.Builder<Type, Any, (Arg1, Arg2, Arg3)> {
    .init { r, _, a in try builder(r, a.0, a.1, a.2) }
}

public func factory<Type, Arg1, Arg2, Arg3>(_ builder: @escaping (Resolver, Arg1, Arg2, Arg3) throws -> Type) -> SimpleBinding.Builder<Type, Any, MatchableBox3<Arg1, Arg2, Arg3>> where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable {
    .init { r, _, a in try builder(r, a.arg1, a.arg2, a.arg3) }
}

public func factory<Type, Arg1, Arg2, Arg3, Arg4>(_ builder: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4) throws -> Type) -> SimpleBinding.Builder<Type, Any, (Arg1, Arg2, Arg3, Arg4)> {
    .init { r, _, a in try builder(r, a.0, a.1, a.2, a.3) }
}

public func factory<Type, Arg1, Arg2, Arg3, Arg4>(_ builder: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4) throws -> Type) -> SimpleBinding.Builder<Type, Any, MatchableBox4<Arg1, Arg2, Arg3, Arg4>> where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable {
    .init { r, _, a in try builder(r, a.arg1, a.arg2, a.arg3, a.arg4) }
}

public func factory<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(_ builder: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4, Arg5) throws -> Type) -> SimpleBinding.Builder<Type, Any, (Arg1, Arg2, Arg3, Arg4, Arg5)> {
    .init { r, _, a in try builder(r, a.0, a.1, a.2, a.3, a.4) }
}

public func factory<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(_ builder: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4, Arg5) throws -> Type) -> SimpleBinding.Builder<Type, Any, MatchableBox5<Arg1, Arg2, Arg3, Arg4, Arg5>> where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable, Arg5: Hashable {
    .init { r, _, a in try builder(r, a.arg1, a.arg2, a.arg3, a.arg4, a.arg5) }
}

public func singleton<Type>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping () throws -> Type) -> ScopedBinding.Builder<Type, UnboundScope, Void> {
    .init(.root, ref) { _, _, _ in try builder() }
}

public func singleton<Type>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver) throws -> Type) -> ScopedBinding.Builder<Type, UnboundScope, Void> {
    .init(.root, ref) { r, _, _ in try builder(r) }
}

public func multiton<Type, Arg1>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Arg1) throws -> Type) -> ScopedBinding.Builder<Type, UnboundScope, Arg1> {
    .init(.root, ref) { r, _, a in try builder(r, a) }
}

public func multiton<Type, Arg1>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Arg1) throws -> Type) -> ScopedBinding.Builder<Type, UnboundScope, MatchableBox1<Arg1>> where Arg1: Hashable {
    .init(.root, ref) { r, _, a in try builder(r, a.arg1) }
}

public func multiton<Type, Arg1, Arg2>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Arg1, Arg2) throws -> Type) -> ScopedBinding.Builder<Type, UnboundScope, (Arg1, Arg2)> {
    .init(.root, ref) { r, _, a in try builder(r, a.0, a.1) }
}

public func multiton<Type, Arg1, Arg2>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Arg1, Arg2) throws -> Type) -> ScopedBinding.Builder<Type, UnboundScope, MatchableBox2<Arg1, Arg2>> where Arg1: Hashable, Arg2: Hashable {
    .init(.root, ref) { r, _, a in try builder(r, a.arg1, a.arg2) }
}

public func multiton<Type, Arg1, Arg2, Arg3>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Arg1, Arg2, Arg3) throws -> Type) -> ScopedBinding.Builder<Type, UnboundScope, (Arg1, Arg2, Arg3)> {
    .init(.root, ref) { r, _, a in try builder(r, a.0, a.1, a.2) }
}

public func multiton<Type, Arg1, Arg2, Arg3>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Arg1, Arg2, Arg3) throws -> Type) -> ScopedBinding.Builder<Type, UnboundScope, MatchableBox3<Arg1, Arg2, Arg3>> where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable {
    .init(.root, ref) { r, _, a in try builder(r, a.arg1, a.arg2, a.arg3) }
}

public func multiton<Type, Arg1, Arg2, Arg3, Arg4>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4) throws -> Type) -> ScopedBinding.Builder<Type, UnboundScope, (Arg1, Arg2, Arg3, Arg4)> {
    .init(.root, ref) { r, _, a in try builder(r, a.0, a.1, a.2, a.3) }
}

public func multiton<Type, Arg1, Arg2, Arg3, Arg4>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4) throws -> Type) -> ScopedBinding.Builder<Type, UnboundScope, MatchableBox4<Arg1, Arg2, Arg3, Arg4>> where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable {
    .init(.root, ref) { r, _, a in try builder(r, a.arg1, a.arg2, a.arg3, a.arg4) }
}

public func multiton<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4, Arg5) throws -> Type) -> ScopedBinding.Builder<Type, UnboundScope, (Arg1, Arg2, Arg3, Arg4, Arg5)> {
    .init(.root, ref) { r, _, a in try builder(r, a.0, a.1, a.2, a.3, a.4) }
}

public func multiton<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4, Arg5) throws -> Type) -> ScopedBinding.Builder<Type, UnboundScope, MatchableBox5<Arg1, Arg2, Arg3, Arg4, Arg5>> where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable, Arg5: Hashable {
    .init(.root, ref) { r, _, a in try builder(r, a.arg1, a.arg2, a.arg3, a.arg4, a.arg5) }
}

// sourcery:end
