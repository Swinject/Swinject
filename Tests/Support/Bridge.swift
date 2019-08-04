//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import func Swinject.bind
import struct Swinject.TypeBinder

// Original Swinject `bind` function conflicts with QuickSpec's instance methods
func bbind<Type>(_: Type.Type, tagged tag: String? = nil, overrides: Bool = false) -> TypeBinder<Type> {
    return bind(Type.self, tagged: tag, overrides: overrides)
}
