//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct BindingRequest<BaseType> {
    let typeDescriptor: AnyTypeDescriptor

    init<Descriptor>(typeDescriptor: Descriptor) where Descriptor: TypeDescriptor, Descriptor.BaseType == BaseType {
        self.typeDescriptor = typeDescriptor
    }
}

public func bind<Type>(_: Type.Type) -> BindingRequest<Type> {
    BindingRequest(typeDescriptor: plain(Type.self))
}

public func bind<Type, Tag>(_: Type.Type, tagged tag: Tag) -> BindingRequest<Type> where Tag: Equatable {
    BindingRequest(typeDescriptor: tagged(Type.self, with: tag))
}

public func bind<Descriptor>(_ descriptor: Descriptor) -> BindingRequest<Descriptor.BaseType> where Descriptor: TypeDescriptor {
    BindingRequest(typeDescriptor: descriptor)
}
