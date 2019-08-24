//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public protocol Resolver {
    func resolve<Type>(_ request: InstanceRequest<Type>) throws -> Type
    func on<Context>(_ context: Context) -> Resolver
}

public protocol SwinjectAware: Resolver {
    var swinject: Resolver { get }
}

public extension SwinjectAware {
    func resolve<Type>(_ request: InstanceRequest<Type>) throws -> Type {
        return try swinject.resolve(request)
    }

    func on<Context>(_ context: Context) -> Resolver {
        return swinject.on(context)
    }
}
