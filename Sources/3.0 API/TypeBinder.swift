//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct TypeBinder<Descriptor> where Descriptor: TypeDescriptor {
    let descriptor: Descriptor
}

public func bind<Type>(_: Type.Type) -> TypeBinder<SomeTypeDescriptor<Type>> {
    return TypeBinder(descriptor: plain(Type.self).opaque)
}

public func bind<Type, Tag>(_: Type.Type, tagged tag: Tag) -> TypeBinder<SomeTypeDescriptor<Type>> where Tag: Hashable {
    return TypeBinder(descriptor: tagged(Type.self, with: tag).opaque)
}

public extension TypeBinder {
    func with<Maker>(_ maker: Maker) -> Binding where Maker: BindingMaker, Maker.BoundType == Descriptor.BaseType {
        return maker.makeBinding(for: descriptor)
    }

    func with(_ value: Descriptor.BaseType) -> Binding {
        return instance(value).makeBinding(for: descriptor)
    }
}

public func & <Descriptor, Maker>(
    lhs: TypeBinder<Descriptor>, rhs: Maker
) -> Binding where Maker: BindingMaker, Maker.BoundType == Descriptor.BaseType {
    return lhs.with(rhs)
}

public func & <Descriptor>(lhs: TypeBinder<Descriptor>, rhs: Descriptor.BaseType) -> Binding {
    return lhs.with(rhs)
}
