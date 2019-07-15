//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// sourcery: AutoMockable
protocol AnyBindingKey {
    var descriptor: AnyTypeDescriptor { get }
    var argumentType: Any.Type { get }

    func matches(_ other: AnyBindingKey) -> Bool
}

public struct BindingKey<Descriptor, Argument>: AnyBindingKey where Descriptor: TypeDescriptor {
    let argumentType: Any.Type = Argument.self
    let descriptor: AnyTypeDescriptor

    func matches(_ other: AnyBindingKey) -> Bool {
        descriptor.matches(other.descriptor) && argumentType == other.argumentType
    }
}
