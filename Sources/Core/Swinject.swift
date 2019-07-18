//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct Swinject {
    let tree: SwinjectTree

    init(tree: SwinjectTree) {
        self.tree = tree
    }
}

extension Swinject: Resolver {
    public func resolve<Descriptor, Context, Argument>(_ request: InstanceRequest<Descriptor, Context, Argument>) throws -> Descriptor.BaseType where Descriptor: TypeDescriptor {
        try instance(from: findBinding(for: request.key), context: request.context, arg: request.argument)
    }

    private func findBinding(for key: AnyBindingKey) throws -> Binding {
        let bindings = tree.bindings.filter { $0.matches(key) }
        guard bindings.count == 1 else { throw SwinjectError() }
        return bindings[0]
    }

    private func instance<Type, Context, Argument>(from binding: Binding, context: Context, arg: Argument) throws -> Type {
        try binding.instance(arg: arg, context: context, resolver: self) as? Type ?? { throw SwinjectError() }()
    }
}
