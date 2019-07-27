//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct ScopedEnvironment<AScope> where AScope: Scope {
    public typealias Context = AScope.Context
    let scope: AScope
}

public struct ContextedEnvironment<Context> {}

public func contexted<Context>(_: Context.Type) -> ContextedEnvironment<Context> {
    ContextedEnvironment()
}

public func scoped<AScope>(_ scope: AScope) -> ScopedEnvironment<AScope> where AScope: Scope {
    ScopedEnvironment(scope: scope)
}

// swiftlint:disable line_length
// swiftlint:disable identifier_name

public func instance<Type>(_ instance: Type) -> SomeBindingMaker<Type> {
    SimpleBinding.Builder<Type, Any, Void> { _, _, _ in instance }.opaque
}

// sourcery:inline:BindingBuilders
extension ContextedEnvironment {
    public func provider<Type>(_ builder: @escaping () throws -> Type) -> SomeBindingMaker<Type> {
        SimpleBinding.Builder<Type, Context, Void> { _, _, _ in try builder() }.opaque
    }

    public func provider<Type>(_ builder: @escaping (Resolver) throws -> Type) -> SomeBindingMaker<Type> {
        SimpleBinding.Builder<Type, Context, Void> { r, _, _ in try builder(r) }.opaque
    }

    public func provider<Type>(_ builder: @escaping (Resolver, Context) throws -> Type) -> SomeBindingMaker<Type> {
        SimpleBinding.Builder<Type, Context, Void> { r, c, _ in try builder(r, c) }.opaque
    }

    public func factory<Type, Arg1>(_ builder: @escaping (Resolver, Context, Arg1) throws -> Type) -> SomeBindingMaker<Type> {
        SimpleBinding.Builder<Type, Context, Arg1> { r, c, a in try builder(r, c, a) }.opaque
    }

    public func factory<Type, Arg1>(_ builder: @escaping (Resolver, Context, Arg1) throws -> Type) -> SomeBindingMaker<Type> where Arg1: Hashable {
        SimpleBinding.Builder<Type, Context, MatchableBox1<Arg1>> { r, c, a in try builder(r, c, a.arg1) }.opaque
    }

    public func factory<Type, Arg1, Arg2>(_ builder: @escaping (Resolver, Context, Arg1, Arg2) throws -> Type) -> SomeBindingMaker<Type> {
        SimpleBinding.Builder<Type, Context, (Arg1, Arg2)> { r, c, a in try builder(r, c, a.0, a.1) }.opaque
    }

    public func factory<Type, Arg1, Arg2>(_ builder: @escaping (Resolver, Context, Arg1, Arg2) throws -> Type) -> SomeBindingMaker<Type> where Arg1: Hashable, Arg2: Hashable {
        SimpleBinding.Builder<Type, Context, MatchableBox2<Arg1, Arg2>> { r, c, a in try builder(r, c, a.arg1, a.arg2) }.opaque
    }

    public func factory<Type, Arg1, Arg2, Arg3>(_ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3) throws -> Type) -> SomeBindingMaker<Type> {
        SimpleBinding.Builder<Type, Context, (Arg1, Arg2, Arg3)> { r, c, a in try builder(r, c, a.0, a.1, a.2) }.opaque
    }

    public func factory<Type, Arg1, Arg2, Arg3>(_ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3) throws -> Type) -> SomeBindingMaker<Type> where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable {
        SimpleBinding.Builder<Type, Context, MatchableBox3<Arg1, Arg2, Arg3>> { r, c, a in try builder(r, c, a.arg1, a.arg2, a.arg3) }.opaque
    }

    public func factory<Type, Arg1, Arg2, Arg3, Arg4>(_ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3, Arg4) throws -> Type) -> SomeBindingMaker<Type> {
        SimpleBinding.Builder<Type, Context, (Arg1, Arg2, Arg3, Arg4)> { r, c, a in try builder(r, c, a.0, a.1, a.2, a.3) }.opaque
    }

    public func factory<Type, Arg1, Arg2, Arg3, Arg4>(_ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3, Arg4) throws -> Type) -> SomeBindingMaker<Type> where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable {
        SimpleBinding.Builder<Type, Context, MatchableBox4<Arg1, Arg2, Arg3, Arg4>> { r, c, a in try builder(r, c, a.arg1, a.arg2, a.arg3, a.arg4) }.opaque
    }

    public func factory<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(_ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3, Arg4, Arg5) throws -> Type) -> SomeBindingMaker<Type> {
        SimpleBinding.Builder<Type, Context, (Arg1, Arg2, Arg3, Arg4, Arg5)> { r, c, a in try builder(r, c, a.0, a.1, a.2, a.3, a.4) }.opaque
    }

    public func factory<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(_ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3, Arg4, Arg5) throws -> Type) -> SomeBindingMaker<Type> where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable, Arg5: Hashable {
        SimpleBinding.Builder<Type, Context, MatchableBox5<Arg1, Arg2, Arg3, Arg4, Arg5>> { r, c, a in try builder(r, c, a.arg1, a.arg2, a.arg3, a.arg4, a.arg5) }.opaque
    }
}

extension ScopedEnvironment {
    public func singleton<Type>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping () throws -> Type) -> SomeBindingMaker<Type> {
        ScopedBinding.Builder<Type, AScope, Void>(scope, ref) { _, _, _ in try builder() }.opaque
    }

    public func singleton<Type>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver) throws -> Type) -> SomeBindingMaker<Type> {
        ScopedBinding.Builder<Type, AScope, Void>(scope, ref) { r, _, _ in try builder(r) }.opaque
    }

    public func singleton<Type>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Context) throws -> Type) -> SomeBindingMaker<Type> {
        ScopedBinding.Builder<Type, AScope, Void>(scope, ref) { r, c, _ in try builder(r, c) }.opaque
    }

    public func multiton<Type, Arg1>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Context, Arg1) throws -> Type) -> SomeBindingMaker<Type> where Arg1: Hashable {
        ScopedBinding.Builder<Type, AScope, MatchableBox1<Arg1>>(scope, ref) { r, c, a in try builder(r, c, a.arg1) }.opaque
    }

    public func multiton<Type, Arg1, Arg2>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Context, Arg1, Arg2) throws -> Type) -> SomeBindingMaker<Type> where Arg1: Hashable, Arg2: Hashable {
        ScopedBinding.Builder<Type, AScope, MatchableBox2<Arg1, Arg2>>(scope, ref) { r, c, a in try builder(r, c, a.arg1, a.arg2) }.opaque
    }

    public func multiton<Type, Arg1, Arg2, Arg3>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3) throws -> Type) -> SomeBindingMaker<Type> where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable {
        ScopedBinding.Builder<Type, AScope, MatchableBox3<Arg1, Arg2, Arg3>>(scope, ref) { r, c, a in try builder(r, c, a.arg1, a.arg2, a.arg3) }.opaque
    }

    public func multiton<Type, Arg1, Arg2, Arg3, Arg4>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3, Arg4) throws -> Type) -> SomeBindingMaker<Type> where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable {
        ScopedBinding.Builder<Type, AScope, MatchableBox4<Arg1, Arg2, Arg3, Arg4>>(scope, ref) { r, c, a in try builder(r, c, a.arg1, a.arg2, a.arg3, a.arg4) }.opaque
    }

    public func multiton<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3, Arg4, Arg5) throws -> Type) -> SomeBindingMaker<Type> where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable, Arg5: Hashable {
        ScopedBinding.Builder<Type, AScope, MatchableBox5<Arg1, Arg2, Arg3, Arg4, Arg5>>(scope, ref) { r, c, a in try builder(r, c, a.arg1, a.arg2, a.arg3, a.arg4, a.arg5) }.opaque
    }
}

public func provider<Type>(_ builder: @escaping () throws -> Type) -> SomeBindingMaker<Type> {
    SimpleBinding.Builder<Type, Any, Void> { _, _, _ in try builder() }.opaque
}

public func provider<Type>(_ builder: @escaping (Resolver) throws -> Type) -> SomeBindingMaker<Type> {
    SimpleBinding.Builder<Type, Any, Void> { r, _, _ in try builder(r) }.opaque
}

public func factory<Type, Arg1>(_ builder: @escaping (Resolver, Arg1) throws -> Type) -> SomeBindingMaker<Type> {
    SimpleBinding.Builder<Type, Any, Arg1> { r, _, a in try builder(r, a) }.opaque
}

public func factory<Type, Arg1>(_ builder: @escaping (Resolver, Arg1) throws -> Type) -> SomeBindingMaker<Type> where Arg1: Hashable {
    SimpleBinding.Builder<Type, Any, MatchableBox1<Arg1>> { r, _, a in try builder(r, a.arg1) }.opaque
}

public func factory<Type, Arg1, Arg2>(_ builder: @escaping (Resolver, Arg1, Arg2) throws -> Type) -> SomeBindingMaker<Type> {
    SimpleBinding.Builder<Type, Any, (Arg1, Arg2)> { r, _, a in try builder(r, a.0, a.1) }.opaque
}

public func factory<Type, Arg1, Arg2>(_ builder: @escaping (Resolver, Arg1, Arg2) throws -> Type) -> SomeBindingMaker<Type> where Arg1: Hashable, Arg2: Hashable {
    SimpleBinding.Builder<Type, Any, MatchableBox2<Arg1, Arg2>> { r, _, a in try builder(r, a.arg1, a.arg2) }.opaque
}

public func factory<Type, Arg1, Arg2, Arg3>(_ builder: @escaping (Resolver, Arg1, Arg2, Arg3) throws -> Type) -> SomeBindingMaker<Type> {
    SimpleBinding.Builder<Type, Any, (Arg1, Arg2, Arg3)> { r, _, a in try builder(r, a.0, a.1, a.2) }.opaque
}

public func factory<Type, Arg1, Arg2, Arg3>(_ builder: @escaping (Resolver, Arg1, Arg2, Arg3) throws -> Type) -> SomeBindingMaker<Type> where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable {
    SimpleBinding.Builder<Type, Any, MatchableBox3<Arg1, Arg2, Arg3>> { r, _, a in try builder(r, a.arg1, a.arg2, a.arg3) }.opaque
}

public func factory<Type, Arg1, Arg2, Arg3, Arg4>(_ builder: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4) throws -> Type) -> SomeBindingMaker<Type> {
    SimpleBinding.Builder<Type, Any, (Arg1, Arg2, Arg3, Arg4)> { r, _, a in try builder(r, a.0, a.1, a.2, a.3) }.opaque
}

public func factory<Type, Arg1, Arg2, Arg3, Arg4>(_ builder: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4) throws -> Type) -> SomeBindingMaker<Type> where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable {
    SimpleBinding.Builder<Type, Any, MatchableBox4<Arg1, Arg2, Arg3, Arg4>> { r, _, a in try builder(r, a.arg1, a.arg2, a.arg3, a.arg4) }.opaque
}

public func factory<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(_ builder: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4, Arg5) throws -> Type) -> SomeBindingMaker<Type> {
    SimpleBinding.Builder<Type, Any, (Arg1, Arg2, Arg3, Arg4, Arg5)> { r, _, a in try builder(r, a.0, a.1, a.2, a.3, a.4) }.opaque
}

public func factory<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(_ builder: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4, Arg5) throws -> Type) -> SomeBindingMaker<Type> where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable, Arg5: Hashable {
    SimpleBinding.Builder<Type, Any, MatchableBox5<Arg1, Arg2, Arg3, Arg4, Arg5>> { r, _, a in try builder(r, a.arg1, a.arg2, a.arg3, a.arg4, a.arg5) }.opaque
}

public func singleton<Type>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping () throws -> Type) -> SomeBindingMaker<Type> {
    ScopedBinding.Builder<Type, UnboundScope, Void>(.root, ref) { _, _, _ in try builder() }.opaque
}

public func singleton<Type>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver) throws -> Type) -> SomeBindingMaker<Type> {
    ScopedBinding.Builder<Type, UnboundScope, Void>(.root, ref) { r, _, _ in try builder(r) }.opaque
}

public func multiton<Type, Arg1>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Arg1) throws -> Type) -> SomeBindingMaker<Type> where Arg1: Hashable {
    ScopedBinding.Builder<Type, UnboundScope, MatchableBox1<Arg1>>(.root, ref) { r, _, a in try builder(r, a.arg1) }.opaque
}

public func multiton<Type, Arg1, Arg2>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Arg1, Arg2) throws -> Type) -> SomeBindingMaker<Type> where Arg1: Hashable, Arg2: Hashable {
    ScopedBinding.Builder<Type, UnboundScope, MatchableBox2<Arg1, Arg2>>(.root, ref) { r, _, a in try builder(r, a.arg1, a.arg2) }.opaque
}

public func multiton<Type, Arg1, Arg2, Arg3>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Arg1, Arg2, Arg3) throws -> Type) -> SomeBindingMaker<Type> where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable {
    ScopedBinding.Builder<Type, UnboundScope, MatchableBox3<Arg1, Arg2, Arg3>>(.root, ref) { r, _, a in try builder(r, a.arg1, a.arg2, a.arg3) }.opaque
}

public func multiton<Type, Arg1, Arg2, Arg3, Arg4>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4) throws -> Type) -> SomeBindingMaker<Type> where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable {
    ScopedBinding.Builder<Type, UnboundScope, MatchableBox4<Arg1, Arg2, Arg3, Arg4>>(.root, ref) { r, _, a in try builder(r, a.arg1, a.arg2, a.arg3, a.arg4) }.opaque
}

public func multiton<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(ref: @escaping ReferenceMaker<Type> = strongRef, _ builder: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4, Arg5) throws -> Type) -> SomeBindingMaker<Type> where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable, Arg5: Hashable {
    ScopedBinding.Builder<Type, UnboundScope, MatchableBox5<Arg1, Arg2, Arg3, Arg4, Arg5>>(.root, ref) { r, _, a in try builder(r, a.arg1, a.arg2, a.arg3, a.arg4, a.arg5) }.opaque
}

// sourcery:end
