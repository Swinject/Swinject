//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import func Swinject.bind
import struct Swinject.NoTag
import struct Swinject.Tagged
import struct Swinject.TypeBinder
import protocol Swinject.TypeDescriptor

// Original Swinject functions conflict with QuickSpec's instance methods
func bbind<Type>(_: Type.Type) -> TypeBinder<Tagged<Type, NoTag>> {
    bind(Type.self)
}

func bbind<Type, Tag>(_: Type.Type, tagged tag: Tag) -> TypeBinder<Tagged<Type, Tag>> where Tag: Equatable {
    bind(Type.self, tagged: tag)
}

func bbind<Descriptor>(_ descriptor: Descriptor) -> TypeBinder<Descriptor> where Descriptor: TypeDescriptor {
    bind(descriptor)
}
