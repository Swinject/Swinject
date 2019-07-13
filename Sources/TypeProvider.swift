//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct TypeProvider<Type>: TypeManipulator {
    public typealias ManipulatedType = Type

    private let factoryMethod: (Provider) throws -> Type

    init(_ factoryMethod: @escaping (Provider) throws -> Type) {
        self.factoryMethod = factoryMethod
    }

    func instance(using provider: Provider) throws -> Type {
        try factoryMethod(provider)
    }
}

public func value<Type>(_ it: Type) -> TypeProvider<Type> {
    TypeProvider { _ in it }
}

public func factory<Type>(_ factoryMethod: @escaping () throws -> Type) -> TypeProvider<Type> {
    TypeProvider { _ in try factoryMethod() }
}

public func factory<Type>(_ factoryMethod: @escaping (Provider) throws -> Type) -> TypeProvider<Type> {
    TypeProvider(factoryMethod)
}
