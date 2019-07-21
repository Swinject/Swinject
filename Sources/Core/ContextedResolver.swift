//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

struct ContextedResolver<Context> {
    let context: Context
    let resolver: Resolver
}

extension ContextedResolver: Resolver {
    func resolve<Descriptor, Ctx, Argument>(
        _ request: InstanceRequest<Descriptor, Ctx, Argument>
    ) throws -> Descriptor.BaseType where Descriptor: TypeDescriptor {
        try resolver.resolve(
            InstanceRequest(
                key: BindingKey<Descriptor, Context, Argument>(descriptor: request.key.descriptor),
                context: context,
                argument: request.argument
            )
        )
    }
}
