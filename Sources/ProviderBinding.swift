//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct ProviderBinding<Type>: Binding {
    public typealias BoundType = Type

    private let builder: (Provider) throws -> Type

    init(_ builder: @escaping (Provider) throws -> Type) {
        self.builder = builder
    }

    func instance(using provider: Provider) throws -> Type {
        try builder(provider)
    }
}

// FIXME: Create InstanceBinding for this
public func value<Type>(_ it: Type) -> ProviderBinding<Type> {
    ProviderBinding { _ in it }
}

public func provider<Type>(_ builder: @escaping () throws -> Type) -> ProviderBinding<Type> {
    ProviderBinding { _ in try builder() }
}

public func factory<Type>(_ builder: @escaping (Provider) throws -> Type) -> ProviderBinding<Type> {
    ProviderBinding(builder)
}

public extension ProviderBinding {
    func map<OtherType>(_ transform: @escaping (Type) -> OtherType) -> ProviderBinding<OtherType> {
        ProviderBinding<OtherType> { try transform(self.instance(using: $0)) }
    }
}
