//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

struct SimpleBinding {
    let key: BindingKey
    let builder: AnyInstanceBuilder
}

extension SimpleBinding: Binding {
    func matches(_ key: BindingKey) -> Bool {
        return self.key.matches(key)
    }

    func instance(arg: Any, context: Any, resolver: Resolver) throws -> Any {
        return try builder.makeInstance(arg: arg, context: context, resolver: resolver)
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

extension SimpleBinding.Builder: InstanceBuilder {
    typealias MadeType = Type

    func makeInstance(arg: Argument, context: Context, resolver: Resolver) throws -> Type {
        return try builder(resolver, context, arg)
    }
}

extension SimpleBinding.Builder: BindingBuilder {
    typealias BoundType = Type

    func makeBinding(for descriptor: AnyTypeDescriptor) -> Binding {
        return SimpleBinding(
            key: BindingKey(descriptor: descriptor, contextType: Context.self, argumentType: Argument.self),
            builder: self
        )
    }
}
