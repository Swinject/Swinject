//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

struct ScopedBinding {
    let key: BindingKey
    let properties: BindingProperties
    let builder: AnyInstanceBuilder
    let scope: AnyScope
    let makeRef: ReferenceMaker<Any>
}

extension ScopedBinding: Binding {
    func matches(_ key: BindingKey) -> Bool {
        return self.key.matches(key)
    }

    func instance(arg: Any, context: Any, resolver: Resolver) throws -> Any {
        return try scope
            .registry(for: context)
            .instance(for: ScopeRegistryKey(descriptor: key.descriptor, argument: arg)) {
                makeRef(try builder.makeInstance(arg: arg, context: context, resolver: resolver))
            }
    }
}

extension ScopedBinding {
    struct Builder<Type, AScope, Argument> where AScope: Scope {
        let scope: AScope
        let makeRef: ReferenceMaker<Any>
        private let builder: (Resolver, Context, Argument) throws -> Type

        init(
            _ scope: AScope,
            _ makeRef: @escaping ReferenceMaker<Type>,
            _ builder: @escaping (Resolver, Context, Argument) throws -> Type
        ) {
            self.makeRef = {
                let ref = makeRef($0 as! Type)
                let nextValue = ref.nextValue
                return Reference(currentValue: ref.currentValue, nextValue: { nextValue() })
            }
            self.scope = scope
            self.builder = builder
        }
    }
}

extension ScopedBinding.Builder: InstanceBuilder {
    typealias MadeType = Type
    typealias Context = AScope.Context

    func makeInstance(arg: Argument, context: Context, resolver: Resolver) throws -> Type {
        return try builder(resolver, context, arg)
    }
}

extension ScopedBinding.Builder: BindingBuilder {
    typealias BoundType = Type

    func makeBinding(with properties: BindingProperties) -> Binding {
        return ScopedBinding(
            key: BindingKey(descriptor: properties.descriptor, contextType: Context.self, argumentType: Argument.self),
            properties: properties,
            builder: self,
            scope: scope,
            makeRef: makeRef
        )
    }
}
