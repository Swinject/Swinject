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
