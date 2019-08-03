//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public protocol Resolver {
    func resolve<Type>(_ request: InjectionRequest) throws -> Type
}

public protocol SwinjectAware: Resolver {
    var swinject: Resolver { get }
}

public extension SwinjectAware {
    func resolve<Type>(_ request: InjectionRequest) throws -> Type {
        return try swinject.resolve(request)
    }
}
