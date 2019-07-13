//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Swinject3

// Original `bind` function conflicts with QuickSpec's instance method
func bbind<Type>(_: Type.Type) -> BindingRequest<Type> {
    Swinject3.bind(Type.self)
}

func bbind<Type, Tag>(_: Type.Type, tagged tag: Tag) -> BindingRequest<Type> where Tag: Equatable {
    Swinject3.bind(Type.self, tagged: tag)
}

func bbind<Descriptor>(_ descriptor: Descriptor) -> BindingRequest<Descriptor.BaseType> where Descriptor: TypeDescriptor {
    Swinject3.bind(descriptor)
}
