//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

struct SimpleBinding {
    let key: BindingKey
    let overrides: Bool
    let builder: AnyInstanceBuilder
}

extension SimpleBinding: AnyBinding {
    func instance(arg: Any, resolver: Resolver) throws -> Any {
        let context = try resolver.context(as: key.contextType)
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

    func makeBinding(with properties: TypeBinderProperties) -> AnyBinding {
        return SimpleBinding(
            key: BindingKey(descriptor: properties.descriptor, contextType: Context.self, argumentType: Argument.self),
            overrides: properties.overrides,
            builder: self
        )
    }
}
