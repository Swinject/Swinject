//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct BindingKey: Hashable {
    let descriptor: AnyTypeDescriptor
    let contextType: Any.Type
    let argumentType: Any.Type

    func matches(_ other: BindingKey) -> Bool {
        return descriptor.matches(other.descriptor)
            && contextType == other.contextType
            && argumentType == other.argumentType
    }

    public func hash(into hasher: inout Hasher) {
        descriptor.hash(into: &hasher)
        ObjectIdentifier(contextType).hash(into: &hasher)
        ObjectIdentifier(argumentType).hash(into: &hasher)
    }

    public static func == (lhs: BindingKey, rhs: BindingKey) -> Bool {
        return lhs.matches(rhs) || rhs.matches(lhs)
    }
}

public protocol Binding: SwinjectEntry {
    var key: BindingKey { get }
    var properties: BindingProperties { get }
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
