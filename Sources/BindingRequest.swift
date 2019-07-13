//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct BindingRequest<Type> {
    let descriptor: AnyTypeDescriptor

    init<Descriptor>(descriptor: Descriptor) where Descriptor: TypeDescriptor, Descriptor.BaseType == Type {
        self.descriptor = descriptor
    }
}

public func bind<Type>(_: Type.Type) -> BindingRequest<Type> {
    BindingRequest(descriptor: plain(Type.self))
}

public func bind<Type, Tag>(_: Type.Type, tagged tag: Tag) -> BindingRequest<Type> where Tag: Equatable {
    BindingRequest(descriptor: tagged(Type.self, with: tag))
}

public func bind<Descriptor>(_ descriptor: Descriptor) -> BindingRequest<Descriptor.BaseType> where Descriptor: TypeDescriptor {
    BindingRequest(descriptor: descriptor)
}

public extension BindingRequest {
    func with<Manipulator>(_ manipulator: Manipulator) -> Binding<Type> where Manipulator: TypeManipulator, Manipulator.ManipulatedType == Type {
        Binding(descriptor: descriptor, manipulator: manipulator)
    }

    func with(_ it: Type) -> Binding<Type> {
        Binding(descriptor: descriptor, manipulator: value(it))
    }
}

public func & <Type, Manipulator>(lhs: BindingRequest<Type>, rhs: Manipulator) -> Binding<Type> where Manipulator: TypeManipulator, Manipulator.ManipulatedType == Type {
    lhs.with(rhs)
}

public func & <Type>(lhs: BindingRequest<Type>, rhs: Type) -> Binding<Type> {
    lhs.with(rhs)
}
