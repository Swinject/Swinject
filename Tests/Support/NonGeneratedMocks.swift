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

class DummyBinding<Context, Argument>: Binding {
    func instance(arg _: Argument, context: Context, resolver _: Resolver) throws -> Any {
        fatalError()
    }
}

// sourcery: AutoMockable
protocol AnyResolver {
    func resolve(_ request: Any) throws -> Any
}

extension AnyResolverMock: Resolver {
    func resolve<Descriptor, Context, Argument>(_ request: BindingRequest<Descriptor, Context, Argument>) throws -> Descriptor.BaseType where Descriptor: TypeDescriptor {
        try resolve(request as Any) as! Descriptor.BaseType
    }
}
