//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

struct SimpleBinding {
    let key: AnyBindingKey
    let maker: AnyInstanceMaker
}

extension SimpleBinding: Binding {
    func matches(_ key: AnyBindingKey) -> Bool {
        self.key.matches(key)
    }

    func instance(arg: Any, context: Any, resolver: Resolver) throws -> Any {
        try maker.makeInstance(arg: arg, context: context, resolver: resolver)
    }
}

extension SimpleBinding {
    struct Builder<Type, Context, Argument> {
        private let builder: (Resolver, Context, Argument) throws -> Type

        init(_ builder: @escaping (Resolver, Context, Argument) throws -> Type) {
            self.builder = builder
        }
    }
}

extension SimpleBinding.Builder: InstanceMaker {
    typealias MadeType = Type

    func makeInstance(arg: Argument, context: Context, resolver: Resolver) throws -> Type {
        try builder(resolver, context, arg)
    }
}

extension SimpleBinding.Builder: BindingMaker {
    typealias BoundType = Type

    func makeBinding(for descriptor: AnyTypeDescriptor) -> Binding {
        SimpleBinding(
            key: BindingKey(descriptor: descriptor, contextType: Context.self, argumentType: Argument.self),
            maker: self
        )
    }
}
