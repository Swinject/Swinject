//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct BindingRequest<BaseType> {
    let descriptor: AnyTypeDescriptor

    init<Descriptor>(descriptor: Descriptor) where Descriptor: TypeDescriptor, Descriptor.BaseType == BaseType {
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
    func with<Manipulator>(_ manipulator: Manipulator) -> Binding<BaseType> where Manipulator: TypeManipulator, Manipulator.ManipulatedType == BaseType {
        Binding(descriptor: descriptor, manipulator: manipulator)
    }
}

public func & <BaseType, Manipulator>(lhs: BindingRequest<BaseType>, rhs: Manipulator) -> Binding<BaseType> where Manipulator: TypeManipulator, Manipulator.ManipulatedType == BaseType {
    lhs.with(rhs)
}
