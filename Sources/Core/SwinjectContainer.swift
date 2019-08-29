//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

struct SwinjectContainer {
    let bindings: [BindingKey: AnyBinding]
    let translators: [AnyContextTranslator]
}

extension SwinjectContainer {
    func checkDependencies() throws {
        try bindings.values
            .flatMap { $0.dependencies }
            .compactMap { $0.asInstanceRequest }
            .forEach {
                if !hasBinding(for: $0, on: Any.self) { throw MissingDependency() }
            }
    }
}

extension SwinjectContainer {
    func hasBinding(for request: InstanceRequestDescriptor, on contextType: Any.Type) -> Bool {
        if let custom = request.type.type as? CustomResolvable.Type {
            return custom.requiredRequest(for: request).map { hasBinding(for: $0, on: contextType) } ?? true
        } else {
            return (try? findBinding(for: request, on: contextType)) != nil
        }
    }

    func findBinding(for request: InstanceRequestDescriptor, on contextType: Any.Type) throws -> AnyBinding {
        let bindings = translatableKeys(for: request, on: contextType).compactMap { self.bindings[$0] }
        if bindings.isEmpty { throw NoBinding() }
        if bindings.count > 1 { throw MultipleBindings() }
        return bindings[0]
    }

    func allTranslators(on contextType: Any.Type) -> [AnyContextTranslator] {
        return translators.filter { $0.sourceType == contextType } + defaultTranslators(on: contextType)
    }

    private func defaultTranslators(on contextType: Any.Type) -> [AnyContextTranslator] {
        return [IdentityTranslator(for: contextType)]
            + (contextType == Any.self ? [] : [ToAnyTranslator(for: contextType)])
    }

    private func translatableKeys(for request: InstanceRequestDescriptor, on contextType: Any.Type) -> [BindingKey] {
        return allTranslators(on: contextType).map { request.key(on: $0.targetType) }
    }
}

private extension BindingDependency {
    var asInstanceRequest: InstanceRequestDescriptor? {
        if case let .instance(descriptor) = self { return descriptor } else { return nil }
    }
}
