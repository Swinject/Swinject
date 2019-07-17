//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// sourcery: AutoMockable
protocol AnyMakerKey {
    var contextType: Any.Type { get }
    var argumentType: Any.Type { get }
    var descriptor: AnyTypeDescriptor { get }

    func matches(_ other: AnyMakerKey) -> Bool
}

public struct MakerKey<Descriptor, Context, Argument>: AnyMakerKey where Descriptor: TypeDescriptor {
    let contextType: Any.Type = Context.self
    let argumentType: Any.Type = Argument.self
    let descriptor: AnyTypeDescriptor

    func matches(_ other: AnyMakerKey) -> Bool {
        descriptor.matches(other.descriptor)
            && (contextType == other.contextType || contextType == Any.self)
            && argumentType == other.argumentType
    }
}
