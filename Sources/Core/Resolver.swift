//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public protocol Resolver {
    func resolve<Type, Argument>(_ request: InstanceRequest<Type, Argument>) throws -> Type
}

public protocol SwinjectAware: Resolver {
    var swinject: Resolver { get }
}

public extension SwinjectAware {
    func resolve<Type, Argument>(_ request: InstanceRequest<Type, Argument>) throws -> Type {
        return try swinject.resolve(request)
    }
}
