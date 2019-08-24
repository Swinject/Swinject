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
    ) -> AnyBindingBuilder where Builder: PartialBindingBuilder, Builder.BoundType == BoundType {
        return FinalBindingBuilder { builder.makeBinding(with: self.properties) }
    }

    func with(_ value: BoundType) -> AnyBindingBuilder {
        return FinalBindingBuilder { instance(value).makeBinding(with: self.properties) }
    }
}

public func & <BoundType, Builder>(
    lhs: TypeBinder<BoundType>, rhs: Builder
) -> AnyBindingBuilder where Builder: PartialBindingBuilder, Builder.BoundType == BoundType {
    return lhs.with(rhs)
}

public func & <BoundType>(lhs: TypeBinder<BoundType>, rhs: BoundType) -> AnyBindingBuilder {
    return lhs.with(rhs)
}
