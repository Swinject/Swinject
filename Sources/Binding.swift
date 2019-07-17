//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// sourcery: AutoMockable
public protocol Binding: SwinjectEntry {
    func matches(_ key: AnyBindingKey) -> Bool
    func instance(arg: Any, context: Any, resolver: Resolver) throws -> Any
}

struct SimpleBinding {
    let key: AnyBindingKey
    let maker: AnyInstanceMaker
}

extension SimpleBinding: Binding {
    // TODO: Proper Unit Tests
    func matches(_ key: AnyBindingKey) -> Bool {
        self.key.matches(key)
    }

    func instance(arg: Any, context: Any, resolver: Resolver) throws -> Any {
        try maker.makeInstance(arg: arg, context: context, resolver: resolver)
    }
}
