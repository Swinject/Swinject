//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// sourcery: AutoMockable
public protocol Binding: SwinjectEntry {
    func matches(_ key: AnyBindingKey) -> Bool
    func instance(arg: Any, context: Any, resolver: Resolver) throws -> Any
}

public protocol BindingMaker {
    func makeBinding<Descriptor>(for descriptor: Descriptor) -> Binding where Descriptor: TypeDescriptor
}
