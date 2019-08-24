//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public protocol PartialBindingBuilder {
    associatedtype BoundType
    func makeBinding(with properties: BindingProperties) -> Binding
}

public struct SomePartialBindingBuilder<BoundType>: PartialBindingBuilder, AnyOpaque {
    let anyActual: Any
    fileprivate let _makeBinding: (BindingProperties) -> Binding

    public func makeBinding(with properties: BindingProperties) -> Binding {
        return _makeBinding(properties)
    }
}

public extension PartialBindingBuilder {
    var opaque: SomePartialBindingBuilder<BoundType> {
        return SomePartialBindingBuilder(anyActual: self) { self.makeBinding(with: $0) }
    }
}

struct FinalBindingBuilder: AnyBindingBuilder {
    let binidngFactory: () -> Binding

    func makeBinding() -> Binding {
        return binidngFactory()
    }
}
