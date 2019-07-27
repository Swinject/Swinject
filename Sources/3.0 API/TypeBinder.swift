//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct TypeBinder<Descriptor> where Descriptor: TypeDescriptor {
    let descriptor: Descriptor
}

public func bind<Type>(_: Type.Type) -> TypeBinder<SomeTypeDescriptor<Type>> {
    TypeBinder(descriptor: plain(Type.self).opaque)
}

public func bind<Type, Tag>(_: Type.Type, tagged tag: Tag) -> TypeBinder<SomeTypeDescriptor<Type>> where Tag: Hashable {
    TypeBinder(descriptor: tagged(Type.self, with: tag).opaque)
}

// TODO: Compiler Bug?
// omitting `decriptor` param name here causes compiler to incorrectly infer types when using bind<Type>(), e.g.:
// bind(CustomStringConvertible.self).with(provider { 42 })
public func bind<Descriptor>(descriptor: Descriptor) -> TypeBinder<Descriptor> where Descriptor: TypeDescriptor {
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
