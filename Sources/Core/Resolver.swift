//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public protocol Resolver {
    func resolve<Descriptor, Argument>(
        _ request: InstanceRequest<Descriptor, Argument>
    ) throws -> Descriptor.BaseType where Descriptor: TypeDescriptor
}
