//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Swinject3

// Original Swinject3 functions conflict with QuickSpec's instance methods
func bbind<Type>(_: Type.Type) -> BindingRequest<Type> {
    Swinject3.bind(Type.self)
}

func bbind<Type, Tag>(_: Type.Type, tagged tag: Tag) -> BindingRequest<Type> where Tag: Equatable {
    Swinject3.bind(Type.self, tagged: tag)
}

func bbind<Descriptor>(_ descriptor: Descriptor) -> BindingRequest<Descriptor.BaseType> where Descriptor: TypeDescriptor {
    Swinject3.bind(descriptor)
}

func vvalue<Type>(_ it: Type) -> TypeProvider<Type> {
    Swinject3.value(it)
}

