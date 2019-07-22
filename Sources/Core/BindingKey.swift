//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// sourcery: AutoMockable
public protocol AnyBindingKey {
    var contextType: Any.Type { get }
    var argumentType: Any.Type { get }
    var descriptor: AnyTypeDescriptor { get }

    func matches(_ other: AnyBindingKey) -> Bool
}

struct BindingKey: AnyBindingKey {
    let descriptor: AnyTypeDescriptor
    let contextType: Any.Type
    let argumentType: Any.Type

    func matches(_ other: AnyBindingKey) -> Bool {
        descriptor.matches(other.descriptor)
            && (contextType == other.contextType || contextType == Any.self)
            && argumentType == other.argumentType
    }
}
