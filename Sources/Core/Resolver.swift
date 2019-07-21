//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public protocol Resolver {
    func resolve<Descriptor, Context, Argument>(_ request: InstanceRequest<Descriptor, Context, Argument>) throws -> Descriptor.BaseType where Descriptor: TypeDescriptor
}

public extension Resolver {
    func on<Context>(_ context: Context) -> Resolver {
        ContextedResolver(context: context, resolver: self)
    }
}
