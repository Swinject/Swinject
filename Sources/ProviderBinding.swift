//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// TODO: Make internal
public struct ProviderBinding<Type>: Binding {
    public typealias BoundType = Type

    private let builder: (Resolver) throws -> Type

    init(_ builder: @escaping (Resolver) throws -> Type) {
        self.builder = builder
    }

    public func instance(arg _: Void, resolver provider: Resolver) throws -> Type {
        try builder(provider)
    }
}

public func provider<Type>(_ builder: @escaping () throws -> Type) -> ProviderBinding<Type> {
    ProviderBinding { _ in try builder() }
}

public func provider<Type>(_ builder: @escaping (Resolver) throws -> Type) -> ProviderBinding<Type> {
    ProviderBinding(builder)
}
