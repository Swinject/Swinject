//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

struct ContextedResolver3<Context> {
    let context: Context
    let resolver: Resolver3
}

extension ContextedResolver3: Resolver3 {
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
