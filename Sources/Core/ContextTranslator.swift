//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

protocol AnyContextTranslator: SwinjectEntry {
    var sourceType: Any.Type { get }
    var targetType: Any.Type { get }
    func translate(_ context: Any) throws -> Any
}

public struct ContextTranslator<Source, Target>: AnyContextTranslator {
    let sourceType: Any.Type = unwrapOptionals(Source.self)
    let targetType: Any.Type = unwrapOptionals(Target.self)
    let translation: (Source) -> Target

    func translate(_ context: Any) throws -> Any {
        guard let context = context as? Source else { throw SwinjectError() }
        return translation(context)
    }
}

struct IdentityTranslator: AnyContextTranslator {
    let sourceType: Any.Type
    let targetType: Any.Type

    init(for contextType: Any.Type) {
        sourceType = unwrapOptionals(contextType)
        targetType = unwrapOptionals(contextType)
    }

    func translate(_ context: Any) throws -> Any { return context }
}

struct ToAnyTranslator: AnyContextTranslator {
    let sourceType: Any.Type
    let targetType: Any.Type = Any.self

    init(for contextType: Any.Type) {
        sourceType = unwrapOptionals(contextType)
    }

    func translate(_ context: Any) throws -> Any { return context }
}

public func registerContextTranslator<Source, Target>(
    from _: Source.Type = Source.self,
    to _: Target.Type = Target.self,
    using translation: @escaping (Source) -> Target
) -> ContextTranslator<Source, Target> {
    return ContextTranslator(translation: translation)
}
