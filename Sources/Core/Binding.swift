//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct BindingKey {
    let descriptor: AnyTypeDescriptor
    let contextType: Any.Type
    let argumentType: Any.Type

    func matches(_ other: BindingKey) -> Bool {
        return descriptor.matches(other.descriptor)
            && (contextType == other.contextType || contextType == Any.self)
            && argumentType == other.argumentType
    }
}

public protocol Binding: SwinjectEntry {
    func matches(_ key: BindingKey) -> Bool
    func instance(arg: Any, context: Any, resolver: Resolver) throws -> Any
}

public protocol BindingBuilder {
    associatedtype BoundType
    func makeBinding(for descriptor: AnyTypeDescriptor) -> Binding
}

public struct SomeBindingBuilder<BoundType>: BindingBuilder, AnyOpaque {
    let anyActual: Any
    fileprivate let _makeBinding: (AnyTypeDescriptor) -> Binding

    public func makeBinding(for descriptor: AnyTypeDescriptor) -> Binding {
        return _makeBinding(descriptor)
    }
}

public extension BindingBuilder {
    var opaque: SomeBindingBuilder<BoundType> {
        return SomeBindingBuilder(anyActual: self) { self.makeBinding(for: $0) }
    }
}
