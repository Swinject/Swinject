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
    var properties: BindingProperties { get }
    func matches(_ key: BindingKey) -> Bool
    func instance(arg: Any, context: Any, resolver: Resolver) throws -> Any
}

public protocol BindingBuilder {
    associatedtype BoundType
    func makeBinding(with properties: BindingProperties) -> Binding
}

public struct SomeBindingBuilder<BoundType>: BindingBuilder, AnyOpaque {
    let anyActual: Any
    fileprivate let _makeBinding: (BindingProperties) -> Binding

    public func makeBinding(with properties: BindingProperties) -> Binding {
        return _makeBinding(properties)
    }
}

public extension BindingBuilder {
    var opaque: SomeBindingBuilder<BoundType> {
        return SomeBindingBuilder(anyActual: self) { self.makeBinding(with: $0) }
    }
}
