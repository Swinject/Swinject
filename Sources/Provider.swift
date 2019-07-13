//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public protocol Provider {
    func instance<Descriptor>(_ type: Descriptor) throws -> Descriptor.BaseType where Descriptor: TypeDescriptor
}
