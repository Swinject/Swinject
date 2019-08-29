//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public protocol Resolver {
    // TODO: Can we absstract the input, and remove `InstanceRequest` from core?
    func resolve<Type>(_ request: InstanceRequest<Type>) throws -> Type
    func on<Context>(_ context: Context) -> Resolver
    func context(as contextType: Any.Type) throws -> Any // TODO: Ideally this should be internal
}

public protocol SwinjectAware {
    var swinject: Resolver { get }
}

public struct ContextedResolver<Context>: Resolver {
    let actual: Resolver

    public func resolve<Type>(_ request: InstanceRequest<Type>) throws -> Type {
        return try actual.resolve(request)
    }

    public func on<Context>(_ context: Context) -> Resolver {
        return actual.on(context)
    }

    public func context(as contextType: Any.Type) throws -> Any {
        return try actual.context(as: contextType)
    }

    public func context() throws -> Context {
        return try context(as: Context.self) as! Context
    }
}

extension Resolver {
    func contexted<Context>() -> ContextedResolver<Context> {
        return ContextedResolver(actual: self)
    }
}
