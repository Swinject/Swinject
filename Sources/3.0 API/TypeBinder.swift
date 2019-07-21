//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct TypeBinder<Descriptor> where Descriptor: TypeDescriptor {
    let descriptor: Descriptor
}

public func bind<Type>(_: Type.Type) -> TypeBinder<Tagged<Type, NoTag>> {
    bind(plain(Type.self))
}

public func bind<Type, Tag>(_: Type.Type, tagged tag: Tag) -> TypeBinder<Tagged<Type, Tag>> where Tag: Equatable {
    bind(tagged(Type.self, with: tag))
}

public func bind<Descriptor>(_ descriptor: Descriptor) -> TypeBinder<Descriptor> where Descriptor: TypeDescriptor {
    TypeBinder(descriptor: descriptor)
}

public extension TypeBinder {
    func with<Maker>(_ maker: Maker) -> Binding where Maker: BindingMaker, Maker.BoundType == Descriptor.BaseType {
        maker.makeBinding(for: descriptor)
    }

    func with(_ value: Descriptor.BaseType) -> Binding {
        instance(value).makeBinding(for: descriptor)
    }
}

public func & <Descriptor, Maker>(
    lhs: TypeBinder<Descriptor>, rhs: Maker
) -> Binding where Maker: BindingMaker, Maker.BoundType == Descriptor.BaseType {
    lhs.with(rhs)
}

public func & <Descriptor>(lhs: TypeBinder<Descriptor>, rhs: Descriptor.BaseType) -> Binding {
    lhs.with(rhs)
}
