//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct ScopedBinding {
    let key: AnyBindingKey
    let maker: AnyInstanceMaker
    let scope: AnyScope
}

extension ScopedBinding: Binding {
    public func matches(_ key: AnyBindingKey) -> Bool {
        self.key.matches(key)
    }

    public func instance(arg: Any, context: Any, resolver: Resolver) throws -> Any {
        try scope
            .registry(for: context)
            .instance(for: ScopeRegistryKey(descriptor: key.descriptor, argument: arg)) {
                try maker.makeInstance(arg: arg, context: context, resolver: resolver)
            }
    }
}

extension ScopedBinding {
    public struct Builder<Type, AScope, Argument> where AScope: Scope {
        let scope: AScope
        private let builder: (Resolver, Context, Argument) throws -> Type

        init(_ scope: AScope, _ builder: @escaping (Resolver, Context, Argument) throws -> Type) {
            self.scope = scope
            self.builder = builder
        }
    }
}

extension ScopedBinding.Builder: InstanceMaker {
    public typealias MadeType = Type
    public typealias Context = AScope.Context

    public func makeInstance(arg: Argument, context: Context, resolver: Resolver) throws -> Type {
        try builder(resolver, context, arg)
    }
}

extension ScopedBinding.Builder: BindingMaker {
    public typealias BoundType = Type

    public func makeBinding<Descriptor>(for descriptor: Descriptor) -> Binding where Descriptor: TypeDescriptor {
        ScopedBinding(
            key: BindingKey(descriptor: descriptor, contextType: Context.self, argumentType: Argument.self),
            maker: self,
            scope: scope
        )
    }
}
