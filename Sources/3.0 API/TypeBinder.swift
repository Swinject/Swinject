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

public func bind<Type>(_: Type.Type, overrides: Bool = false) -> TypeBinder<Type> {
    return TypeBinder(properties: BindingProperties(
        descriptor: plain(Type.self),
        overrides: overrides
    ))
}

public func bind<Type, Tag>(
    _: Type.Type, tagged tag: Tag, overrides: Bool = false
) -> TypeBinder<Type> where Tag: Hashable {
    return TypeBinder(properties: BindingProperties(
        descriptor: tagged(Type.self, with: tag),
        overrides: overrides
    ))
}

public extension TypeBinder {
    func with<Builder>(
        _ builder: Builder
    ) -> Binding where Builder: BindingBuilder, Builder.BoundType == BoundType {
        return builder.makeBinding(with: properties)
    }

    func with(_ value: BoundType) -> Binding {
        return instance(value).makeBinding(with: properties)
    }
}

public func & <BoundType, Builder>(
    lhs: TypeBinder<BoundType>, rhs: Builder
) -> Binding where Builder: BindingBuilder, Builder.BoundType == BoundType {
    return lhs.with(rhs)
}

public func & <BoundType>(lhs: TypeBinder<BoundType>, rhs: BoundType) -> Binding {
    return lhs.with(rhs)
}
