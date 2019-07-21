//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// TODO: Rename
public protocol Resolver3 {
    func resolve<Descriptor, Context, Argument>(
        _ request: InstanceRequest<Descriptor, Context, Argument>
    ) throws -> Descriptor.BaseType where Descriptor: TypeDescriptor
}

public extension Resolver3 {
    func on<Context>(_ context: Context) -> Resolver3 {
        ContextedResolver3(context: context, resolver: self)
    }
}
