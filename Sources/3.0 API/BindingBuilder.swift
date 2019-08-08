//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

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

public protocol AnyBindingBuilder: SwinjectEntry {
    func makeBinding() -> Binding
}

struct FinalBindingBuilder: AnyBindingBuilder {
    let binidngFactory: () -> Binding

    func makeBinding() -> Binding {
        return binidngFactory()
    }
}
