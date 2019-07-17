//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// FIXME: AScope is suboptimal name for a parameter
// Can we rename Scope -> ScopeProtocol?
public struct ScopedBinding {}

extension ScopedBinding {
    public struct Builder<Type, AScope, Argument>: InstanceMaker where AScope: Scope {
        public typealias MadeType = Type
        public typealias Context = AScope.Context

        let scope: AScope
        private let builder: (Resolver, Context, Argument) throws -> Type

        init(_ scope: AScope, _ builder: @escaping (Resolver, Context, Argument) throws -> Type) {
            self.scope = scope
            self.builder = builder
        }

        public func makeInstance(arg: Argument, context: Context, resolver: Resolver) throws -> Type {
            try builder(resolver, context, arg)
        }
    }
}
