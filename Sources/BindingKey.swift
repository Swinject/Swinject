//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// sourcery: AutoMockable
protocol AnyBindingKey {
    var contextType: Any.Type { get }
    var argumentType: Any.Type { get }
    var descriptor: AnyTypeDescriptor { get }

    func matches(_ other: AnyBindingKey) -> Bool
}

public struct BindingKey<Descriptor, Context, Argument>: AnyBindingKey where Descriptor: TypeDescriptor {
    let contextType: Any.Type = Context.self
    let argumentType: Any.Type = Argument.self
    let descriptor: AnyTypeDescriptor

    func matches(_ other: AnyBindingKey) -> Bool {
        descriptor.matches(other.descriptor)
            && (contextType == other.contextType || contextType == Any.self)
            && argumentType == other.argumentType
    }
}
