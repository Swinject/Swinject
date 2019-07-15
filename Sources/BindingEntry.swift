//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// sourcery: AutoMockable
protocol AnyBindingEntry: SwinjectEntry {
    var key: AnyBindingKey { get }
    var binding: AnyBinding { get }
}

// TODO: Make this internal
public struct BindingEntry<Type>: AnyBindingEntry {
    let key: AnyBindingKey
    let binding: AnyBinding
}

protocol AnyBindingKey {
    var descriptor: AnyTypeDescriptor { get }
    var argumentType: Any.Type { get }
}

struct BindingKey<Descriptor, Argument>: AnyBindingKey where Descriptor: TypeDescriptor {
    let argumentType: Any.Type = Argument.self
    let descriptor: AnyTypeDescriptor
}
