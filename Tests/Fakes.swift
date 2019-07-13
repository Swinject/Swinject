//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Swinject3

class FakeProvider: Provider {
    func instance<Descriptor>(_ type: Descriptor) throws -> Descriptor.BaseType where Descriptor : TypeDescriptor {
        fatalError()
    }
}

class IntManipulator: TypeManipulator {
    typealias ManipulatedType = Int
}

class IntDescriptor: TypeDescriptor {
    typealias BaseType = Int
}
