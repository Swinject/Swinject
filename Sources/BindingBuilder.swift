//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct BindingBuilder<Context> {}

public func contexted<Context>(_: Context.Type = Context.self) -> BindingBuilder<Context> {
    BindingBuilder()
}

extension BindingBuilder {
    public func provider<Type>(_ builder: @escaping (Resolver, Context) throws -> Type) -> SimpleBinding<Type, Context, Void> {
        SimpleBinding { r, c, _ in try builder(r, c) }
    }

    public func factory<Type, Arg1>(_ builder: @escaping (Resolver, Context, Arg1) throws -> Type) -> SimpleBinding<Type, Context, Arg1> {
        SimpleBinding(builder)
    }

    public func factory<Type, Arg1, Arg2>(_ builder: @escaping (Resolver, Context, Arg1, Arg2) throws -> Type) -> SimpleBinding<Type, Context, (Arg1, Arg2)> {
        SimpleBinding { try builder($0, $1, $2.0, $2.1) }
    }

    public func factory<Type, Arg1, Arg2, Arg3>(_ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3) throws -> Type) -> SimpleBinding<Type, Context, (Arg1, Arg2, Arg3)> {
        SimpleBinding { try builder($0, $1, $2.0, $2.1, $2.2) }
    }

    public func factory<Type, Arg1, Arg2, Arg3, Arg4>(_ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3, Arg4) throws -> Type) -> SimpleBinding<Type, Context, (Arg1, Arg2, Arg3, Arg4)> {
        SimpleBinding { try builder($0, $1, $2.0, $2.1, $2.2, $2.3) }
    }

    public func factory<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(_ builder: @escaping (Resolver, Context, Arg1, Arg2, Arg3, Arg4, Arg5) throws -> Type) -> SimpleBinding<Type, Context, (Arg1, Arg2, Arg3, Arg4, Arg5)> {
        SimpleBinding { try builder($0, $1, $2.0, $2.1, $2.2, $2.3, $2.4) }
    }
}

public func instance<Type>(_ instance: Type) -> SimpleBinding<Type, Any, Void> {
    SimpleBinding { _, _, _ in instance }
}

public func provider<Type>(_ builder: @escaping () throws -> Type) -> SimpleBinding<Type, Any, Void> {
    SimpleBinding { _, _, _ in try builder() }
}

public func provider<Type>(_ builder: @escaping (Resolver) throws -> Type) -> SimpleBinding<Type, Any, Void> {
    SimpleBinding { r, _, _ in try builder(r) }
}

public func factory<Type, Arg1>(_ builder: @escaping (Resolver, Arg1) throws -> Type) -> SimpleBinding<Type, Any, Arg1> {
    SimpleBinding { try builder($0, $2) }
}

public func factory<Type, Arg1, Arg2>(_ builder: @escaping (Resolver, Arg1, Arg2) throws -> Type) -> SimpleBinding<Type, Any, (Arg1, Arg2)> {
    SimpleBinding { try builder($0, $2.0, $2.1) }
}

public func factory<Type, Arg1, Arg2, Arg3>(_ builder: @escaping (Resolver, Arg1, Arg2, Arg3) throws -> Type) -> SimpleBinding<Type, Any, (Arg1, Arg2, Arg3)> {
    SimpleBinding { try builder($0, $2.0, $2.1, $2.2) }
}

public func factory<Type, Arg1, Arg2, Arg3, Arg4>(_ builder: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4) throws -> Type) -> SimpleBinding<Type, Any, (Arg1, Arg2, Arg3, Arg4)> {
    SimpleBinding { try builder($0, $2.0, $2.1, $2.2, $2.3) }
}

public func factory<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(_ builder: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4, Arg5) throws -> Type) -> SimpleBinding<Type, Any, (Arg1, Arg2, Arg3, Arg4, Arg5)> {
    SimpleBinding { try builder($0, $2.0, $2.1, $2.2, $2.3, $2.4) }
}
