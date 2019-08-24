//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public typealias AnyContext = Any
public typealias NoArgument = Void
public typealias NoScope = Void

public func register<Context>(inContextOf _: Context.Type) -> SomeBinding<Void, NoScope, Context, NoArgument> {
    return SomeBinding(keys: Set(), dependencies: [], factory: { _, _, in }, properties: .default, scope: ())
}

public func register() -> SomeBinding<Void, NoScope, AnyContext, NoArgument> {
    return register(inContextOf: Any.self)
}

public func registerSingle<AScope: Scope>(in scope: AScope) -> SomeBinding<Void, AScope, AScope.Context, NoArgument> {
    return SomeBinding(keys: Set(), dependencies: [], factory: { _, _ in }, properties: .default, scope: scope)
}

public func registerSingle() -> SomeBinding<Void, UnboundScope, AnyContext, NoArgument> {
    return registerSingle(in: .root)
}

public extension Binding where Instance == Void {
    func constant<Value>(
        _ value: Value, as _: Value.Type = Value.self, tag: String? = nil
    ) -> SomeBinding<Value, AScope, Context, NoArgument> {
        return updatedFactory { _, _ in value }.updated {
            $0.products = [tagged(Value.self, with: tag)]
            $0.dependencies = .none
        }
    }

    // TODO: Oveloads for argument variations
    func factory<NewInstance, NewArgument>(
        for _: NewInstance.Type = NewInstance.self,
        tag: String? = nil,
        factory: @escaping (ContextedResolver<Context>, NewArgument) throws -> NewInstance
    ) -> SomeBinding<NewInstance, AScope, Context, NewArgument> {
        return updatedFactory(factory: factory).updated {
            $0.products = [tagged(NewInstance.self, with: tag)]
            $0.dependencies = .undefined
        }
    }
}

public extension Binding where {
    func toUse<OtherInstance>(_: (Instance) -> OtherInstance, tag: String? = nil) -> Self {
        return updated { $0.products = [tagged(OtherInstance.self, with: tag)] }
    }

    func alsoUse<OtherInstance>(_: (Instance) -> OtherInstance, tag: String? = nil) -> Self {
        return updated { $0.products.append(tagged(OtherInstance.self, with: tag)) }
    }
}

public extension Binding {
    func withProperties(_ update: (inout BindingProperties) -> Void) -> Self {
        return updated { update(&$0.properties) }
    }
}
