//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Swinject

class FakeInjector: Injector {
    func instance<Descriptor, Dependency>(_ type: Descriptor, with dependency: Dependency) throws -> Descriptor.BaseType where Descriptor : TypeDescriptor {
        fatalError()
    }
}

class IntBinding: Binding {
    func instance(using provider: Injector) throws -> Int { 0 }
}

class IntDescriptor: TypeDescriptor {
    typealias BaseType = Int

    func matches<Descriptor>(_ other: Descriptor) -> Bool where Descriptor : TypeDescriptor {
        false
    }
}
