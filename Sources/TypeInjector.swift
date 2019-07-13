//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct TypeInjector<Type>: TypeManipulator {
    public typealias ManipulatedType = Type

    private let injectionMethod: (Type, Provider) throws -> Void

    init(_ injectionMethod: @escaping (Type, Provider) throws -> Void) {
        self.injectionMethod = injectionMethod
    }

    func inject(_ instance: Type, using provider: Provider) throws {
        try injectionMethod(instance, provider)
    }
}

public func injector<Type>(of: Type.Type = Type.self, injectionMethod: @escaping (Type) throws -> Void) -> TypeInjector<Type> {
    TypeInjector { instance, _ in try injectionMethod(instance) }
}

public func injector<Type>(of: Type.Type = Type.self, injectionMethod: @escaping (Type, Provider) throws -> Void) -> TypeInjector<Type> {
    TypeInjector(injectionMethod)
}
