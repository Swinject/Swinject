//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// sourcery: AutoMockable
protocol AnyBindingEntry: SwinjectEntry {
    var descriptor: AnyTypeDescriptor { get }
    var binding: AnyBinding { get }
}

// TODO: Make this internal
public struct BindingEntry<Type>: AnyBindingEntry {
    let descriptor: AnyTypeDescriptor
    let binding: AnyBinding
}
