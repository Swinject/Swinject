//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct TypeBinder<Type> {
    let descriptor: AnyTypeDescriptor

    init<Descriptor>(descriptor: Descriptor) where Descriptor: TypeDescriptor, Descriptor.BaseType == Type {
        self.descriptor = descriptor
    }
}

public func bind<Type>(_: Type.Type) -> TypeBinder<Type> {
    TypeBinder(descriptor: plain(Type.self))
}

public func bind<Type, Tag>(_: Type.Type, tagged tag: Tag) -> TypeBinder<Type> where Tag: Equatable {
    TypeBinder(descriptor: tagged(Type.self, with: tag))
}

public func bind<Descriptor>(_ descriptor: Descriptor) -> TypeBinder<Descriptor.BaseType> where Descriptor: TypeDescriptor {
    TypeBinder(descriptor: descriptor)
}

public extension TypeBinder {
    func with<SomeBinding>(_ binding: SomeBinding) -> BindingEntry<Type> where SomeBinding: Binding, SomeBinding.BoundType == Type {
        BindingEntry(descriptor: descriptor, binding: binding)
    }

    func with(_ it: Type) -> BindingEntry<Type> {
        BindingEntry(descriptor: descriptor, binding: value(it))
    }
}

public func & <Type, SomeBinding>(lhs: TypeBinder<Type>, rhs: SomeBinding) -> BindingEntry<Type> where SomeBinding: Binding, SomeBinding.BoundType == Type {
    lhs.with(rhs)
}

public func & <Type>(lhs: TypeBinder<Type>, rhs: Type) -> BindingEntry<Type> {
    lhs.with(rhs)
}
