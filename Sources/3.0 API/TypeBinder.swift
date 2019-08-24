//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct BindingProperties {
    let descriptor: TypeDescriptor
    let overrides: Bool
}

public struct TypeBinder<BoundType> {
    let properties: BindingProperties
}

public func bind<Type>(_: Type.Type, tagged tag: String? = nil, overrides: Bool = false) -> TypeBinder<Type> {
    return TypeBinder(properties: BindingProperties(
        descriptor: tagged(Type.self, with: tag),
        overrides: overrides
    ))
}

public extension TypeBinder {
    func with<Builder>(
        _ builder: Builder
    ) -> AnyBinding where Builder: BindingBuilder, Builder.BoundType == BoundType {
        return builder.makeBinding(with: properties)
    }

    func with(_ value: BoundType) -> AnyBinding {
        return instance(value).makeBinding(with: properties)
    }
}

public func & <BoundType, Builder>(
    lhs: TypeBinder<BoundType>, rhs: Builder
) -> AnyBinding where Builder: BindingBuilder, Builder.BoundType == BoundType {
    return lhs.with(rhs)
}

public func & <BoundType>(lhs: TypeBinder<BoundType>, rhs: BoundType) -> AnyBinding {
    return lhs.with(rhs)
}
