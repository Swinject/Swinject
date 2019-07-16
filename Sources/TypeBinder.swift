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
    func with<SomeBinding>(_ binding: SomeBinding) -> BindingEntry<Descriptor.BaseType> where SomeBinding: Binding, SomeBinding.BoundType == Descriptor.BaseType {
        BindingEntry(key: BindingKey<Descriptor, Void, SomeBinding.Argument>(descriptor: descriptor), binding: binding)
    }

    func with(_ anInstance: Descriptor.BaseType) -> BindingEntry<Descriptor.BaseType> {
        with(instance(anInstance))
    }
}

public func & <Descriptor, SomeBinding>(lhs: TypeBinder<Descriptor>, rhs: SomeBinding) -> BindingEntry<Descriptor.BaseType> where SomeBinding: Binding, SomeBinding.BoundType == Descriptor.BaseType {
    lhs.with(rhs)
}

public func & <Descriptor>(lhs: TypeBinder<Descriptor>, rhs: Descriptor.BaseType) -> BindingEntry<Descriptor.BaseType> {
    lhs.with(rhs)
}
