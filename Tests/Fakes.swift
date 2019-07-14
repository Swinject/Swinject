//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Swinject

class FakeProvider: Provider {
    func instance<Descriptor, Dependency>(_ type: Descriptor, with dependency: Dependency) throws -> Descriptor.BaseType where Descriptor : TypeDescriptor {
        fatalError()
    }
}

class IntBinding: Binding {
    typealias BoundType = Int
}

class IntDescriptor: TypeDescriptor {
    typealias BaseType = Int

    func matches<Descriptor>(_ other: Descriptor) -> Bool where Descriptor : TypeDescriptor {
        false
    }
}
