//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

@testable import Swinject

class DummyResolver: Resolver {
    func resolve<Descriptor, Context, Argument>(_: BindingRequest<Descriptor, Context, Argument>) throws -> Descriptor.BaseType where Descriptor: TypeDescriptor {
        fatalError()
    }
}

extension AnyTypeDescriptorMock: TypeDescriptor {
    typealias BaseType = Any
}

extension AnyBindingMock: Binding {
    typealias Argument = Any
}

class DummyBinding<Argument>: Binding {
    func instance(arg _: Argument, context: Void, resolver _: Resolver) throws -> Any {
        fatalError()
    }
}
