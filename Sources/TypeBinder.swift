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
    func with<Manipulator>(_ manipulator: Manipulator) -> Binding<Type> where Manipulator: TypeManipulator, Manipulator.ManipulatedType == Type {
        Binding(descriptor: descriptor, manipulator: manipulator)
    }

    func with(_ it: Type) -> Binding<Type> {
        Binding(descriptor: descriptor, manipulator: value(it))
    }
}

public func & <Type, Manipulator>(lhs: TypeBinder<Type>, rhs: Manipulator) -> Binding<Type> where Manipulator: TypeManipulator, Manipulator.ManipulatedType == Type {
    lhs.with(rhs)
}

public func & <Type>(lhs: TypeBinder<Type>, rhs: Type) -> Binding<Type> {
    lhs.with(rhs)
}
