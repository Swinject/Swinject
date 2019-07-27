//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// sourcery: AutoMockable
public protocol Binding: SwinjectEntry {
    func matches(_ key: AnyBindingKey) -> Bool
    func instance(arg: Any, context: Any, resolver: Resolver) throws -> Any
}

// sourcery: AutoMockable
public protocol BindingMaker {
    associatedtype BoundType
    func makeBinding(for descriptor: AnyTypeDescriptor) -> Binding
}

public struct SomeBindingMaker<BoundType>: BindingMaker, AnyOpaque {
    let anyActual: Any
    fileprivate let _makeBinding: (AnyTypeDescriptor) -> Binding

    public func makeBinding(for descriptor: AnyTypeDescriptor) -> Binding {
        _makeBinding(descriptor)
    }
}

public extension BindingMaker {
    var opaque: SomeBindingMaker<BoundType> {
        SomeBindingMaker(anyActual: self) { self.makeBinding(for: $0) }
    }
}
