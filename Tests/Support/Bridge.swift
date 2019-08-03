//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import func Swinject.bind
import struct Swinject.TypeBinder

// Original Swinject functions conflict with QuickSpec's instance methods
func bbind<Type>(_: Type.Type, overrides: Bool = false) -> TypeBinder<Type> {
    return bind(Type.self, overrides: overrides)
}

func bbind<Type, Tag>(_: Type.Type, tagged tag: Tag, overrides: Bool = false) -> TypeBinder<Type> where Tag: Hashable {
    return bind(Type.self, tagged: tag, overrides: overrides)
}
