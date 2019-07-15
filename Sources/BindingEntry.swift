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
