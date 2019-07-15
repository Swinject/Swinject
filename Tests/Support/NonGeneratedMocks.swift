//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

@testable import Swinject

class FakeInjector: Injector {
    func instance<Descriptor>(_: Descriptor) throws -> Descriptor.BaseType where Descriptor: TypeDescriptor {
        fatalError()
    }

    func provider<Descriptor>(_: Descriptor) throws -> () throws -> Descriptor.BaseType where Descriptor: TypeDescriptor {
        fatalError()
    }
}

extension AnyTypeDescriptorMock: TypeDescriptor {
    typealias BaseType = Any
}

extension AnyBindingMock: Binding {
    typealias Argument = Any
}
