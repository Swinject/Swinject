//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct SimpleBinding {
    let key: AnyBindingKey
    let maker: AnyInstanceMaker
}

extension SimpleBinding: Binding {
    public func matches(_ key: AnyBindingKey) -> Bool {
        self.key.matches(key)
    }

    public func instance(arg: Any, context: Any, resolver: Resolver) throws -> Any {
        try maker.makeInstance(arg: arg, context: context, resolver: resolver)
    }
}

extension SimpleBinding {
    public struct Builder<Type, Context, Argument>: InstanceMaker {
        public typealias MadeType = Type

        private let builder: (Resolver, Context, Argument) throws -> Type

        init(_ builder: @escaping (Resolver, Context, Argument) throws -> Type) {
            self.builder = builder
        }

        public func makeInstance(arg: Argument, context: Context, resolver: Resolver) throws -> Type {
            try builder(resolver, context, arg)
        }
    }
}
