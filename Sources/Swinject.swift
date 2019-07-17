//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct Swinject {
    let tree: SwinjectTree

    init(tree: SwinjectTree) {
        self.tree = tree
    }
}

public extension Swinject {
    init(@SwinjectTreeBuilder builder: () -> [SwinjectEntry]) {
        self.init(tree: SwinjectTreeBuilder.buildFunction(builder()))
    }

    init(@SwinjectTreeBuilder builder: () -> SwinjectEntry) {
        self.init(tree: SwinjectTreeBuilder.buildFunction([builder()]))
    }

    init(@SwinjectTreeBuilder _: () -> Void) {
        self.init(tree: SwinjectTreeBuilder.buildFunction([]))
    }
}

extension Swinject: Resolver {
    public func resolve<Descriptor, Context, Argument>(_ request: MakerRequest<Descriptor, Context, Argument>) throws -> Descriptor.BaseType where Descriptor: TypeDescriptor {
        try instance(from: findMaker(for: request.key), context: request.context, arg: request.argument)
    }

    private func findMaker(for key: AnyBindingKey) throws -> AnyInstanceMaker {
        let bindings = tree.bindings.compactMap { $0 as? SimpleBinding }.filter { $0.key.matches(key) }
        guard bindings.count == 1 else { throw SwinjectError() }
        return bindings[0].maker
    }

    private func instance<Type, Context, Argument>(from maker: AnyInstanceMaker, context: Context, arg: Argument) throws -> Type {
        try maker.makeInstance(arg: arg, context: context, resolver: self) as? Type ?? { throw SwinjectError() }()
    }
}
