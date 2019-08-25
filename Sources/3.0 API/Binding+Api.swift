//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public func register<Context>(inContextOf _: Context.Type) -> Binding<Void, Context> {
    return Binding(
        products: [],
        dependencies: [],
        factory: { _, _ in },
        properties: .default,
        scope: nil,
        arguments: []
    )
}

public func register() -> Binding<Void, Any> {
    return register(inContextOf: Any.self)
}

public func registerSingle<AScope: Scope>(in scope: AScope) -> Binding<Void, AScope.Context> {
    return Binding(
        products: [],
        dependencies: [],
        factory: { _, _ in },
        properties: .default,
        scope: scope,
        arguments: []
    )
}

public func registerSingle() -> Binding<Void, UnboundScope.Context> {
    return registerSingle(in: UnboundScope.root)
}

public extension Binding where Instance == Void {
    func constant<Value>(_ value: Value, tag: String? = nil) -> Binding<Value, Context> {
        return updatedFactory { _, _ in value }.updated {
            $0.products = [tagged(Value.self, with: tag)]
            $0.dependencies = []
            $0.arguments = []
        }
    }

    func resultOf<NewInstance>(
        _ call: FunctionCall<NewInstance>,
        as _: NewInstance.Type = NewInstance.self,
        tag: String? = nil
    ) -> Binding<NewInstance, Context> {
        return updatedFactory(factory: call.execute).updated {
            // TODO: assert context type
            $0.products = [tagged(NewInstance.self, with: tag)]
            $0.dependencies = call.inputs.map { $0.asDependency }
            $0.arguments = Arguments.Descriptor(types: call.inputs.compactMap {
                if case let .argument(type) = $0.asDependency { return type } else { return nil }
            })
        }
    }
}

public extension Binding {
    func toUse<OtherInstance>(_: (Instance) -> OtherInstance, tag: String?) -> Binding<Instance, Context> {
        return updated { $0.products = [tagged(OtherInstance.self, with: tag)] }
    }

    func toUse<OtherInstance>(_ typeCheck: (Instance) -> OtherInstance) -> Binding<Instance, Context> {
        return toUse(typeCheck, tag: nil)
    }

    func alsoUse<OtherInstance>(_: (Instance) -> OtherInstance, tag: String? = nil) -> Binding<Instance, Context> {
        return updated { $0.products.append(tagged(OtherInstance.self, with: tag)) }
    }

    func alsoUse<OtherInstance>(_ typeCheck: (Instance) -> OtherInstance) -> Binding<Instance, Context> {
        return alsoUse(typeCheck, tag: nil)
    }
}

public extension Binding {
    func withProperties(_ update: (inout BindingProperties) -> Void) -> Binding<Instance, Context> {
        return updated { update(&$0.properties) }
    }
}
