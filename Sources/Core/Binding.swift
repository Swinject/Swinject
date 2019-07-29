//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct BindingKey: Hashable {
    let descriptor: AnyTypeDescriptor
    let contextType: Any.Type
    let argumentType: Any.Type

    func matches(_ other: BindingKey) -> Bool {
        return descriptor.matches(other.descriptor)
            && (contextType == other.contextType || contextType == Any.self)
            && argumentType == other.argumentType
    }

    public func hash(into hasher: inout Hasher) {
        descriptor.hash(into: &hasher)
        String(describing: contextType).hash(into: &hasher)
        String(describing: argumentType).hash(into: &hasher)
    }

    public static func == (lhs: BindingKey, rhs: BindingKey) -> Bool {
        return lhs.matches(rhs) || rhs.matches(lhs)
    }
}

public protocol Binding: SwinjectEntry {
    var key: BindingKey { get }
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
