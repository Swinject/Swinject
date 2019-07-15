//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// sourcery: AutoMockable
protocol AnyBindingEntry: SwinjectEntry {
    var key: BindingKey { get }
    var binding: AnyBinding { get }
}

// TODO: Make this internal
public struct BindingEntry<Type>: AnyBindingEntry {
    let key: BindingKey
    let binding: AnyBinding
}

struct BindingKey {
    let descriptor: AnyTypeDescriptor
}
