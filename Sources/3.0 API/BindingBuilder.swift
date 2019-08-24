//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public protocol BindingBuilder {
    associatedtype BoundType
    func makeBinding(with properties: TypeBinderProperties) -> AnyBinding
}

public struct SomeBindingBuilder<BoundType>: BindingBuilder, AnyOpaque {
    let anyActual: Any
    fileprivate let _makeBinding: (TypeBinderProperties) -> AnyBinding

    public func makeBinding(with properties: TypeBinderProperties) -> AnyBinding {
        return _makeBinding(properties)
    }
}

public extension BindingBuilder {
    var opaque: SomeBindingBuilder<BoundType> {
        return SomeBindingBuilder(anyActual: self) { self.makeBinding(with: $0) }
    }
}
