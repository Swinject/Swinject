//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public func instance<Type>(_ instance: Type) -> SimpleBinding<Type, Void> {
    SimpleBinding { _, _ in instance }
}

public func provider<Type>(_ builder: @escaping () throws -> Type) -> SimpleBinding<Type, Void> {
    SimpleBinding { _, _ in try builder() }
}

public func provider<Type>(_ builder: @escaping (Resolver) throws -> Type) -> SimpleBinding<Type, Void> {
    SimpleBinding { resolver, _ in try builder(resolver) }
}

public func factory<Type, Arg1>(_ builder: @escaping (Resolver, Arg1) throws -> Type) -> SimpleBinding<Type, Arg1> {
    SimpleBinding(builder)
}

public func factory<Type, Arg1, Arg2>(_ builder: @escaping (Resolver, Arg1, Arg2) throws -> Type) -> SimpleBinding<Type, (Arg1, Arg2)> {
    SimpleBinding { try builder($0, $1.0, $1.1) }
}

public func factory<Type, Arg1, Arg2, Arg3>(_ builder: @escaping (Resolver, Arg1, Arg2, Arg3) throws -> Type) -> SimpleBinding<Type, (Arg1, Arg2, Arg3)> {
    SimpleBinding { try builder($0, $1.0, $1.1, $1.2) }
}

public func factory<Type, Arg1, Arg2, Arg3, Arg4>(_ builder: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4) throws -> Type) -> SimpleBinding<Type, (Arg1, Arg2, Arg3, Arg4)> {
    SimpleBinding { try builder($0, $1.0, $1.1, $1.2, $1.3) }
}

public func factory<Type, Arg1, Arg2, Arg3, Arg4, Arg5>(_ builder: @escaping (Resolver, Arg1, Arg2, Arg3, Arg4, Arg5) throws -> Type) -> SimpleBinding<Type, (Arg1, Arg2, Arg3, Arg4, Arg5)> {
    SimpleBinding { try builder($0, $1.0, $1.1, $1.2, $1.3, $1.4) }
}
