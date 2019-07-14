//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct BindingEntry<Type>: SwinjectEntry {
    let descriptor: AnyTypeDescriptor
    let binding: AnyBinding // TODO: Rename to binding
}
