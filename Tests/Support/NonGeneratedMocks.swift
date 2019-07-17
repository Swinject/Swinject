//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

@testable import Swinject

class DummyResolver: Resolver {
    func resolve<Descriptor, Context, Argument>(_: InstanceRequest<Descriptor, Context, Argument>) throws -> Descriptor.BaseType where Descriptor: TypeDescriptor {
        fatalError()
    }
}

extension AnyTypeDescriptorMock: TypeDescriptor {
    typealias BaseType = Any
}

extension AnyInstanceMakerMock: InstanceMaker {
    typealias Argument = Any
}

class DummyMaker<Context, Argument>: InstanceMaker {
    func makeInstance(arg _: Argument, context: Context, resolver _: Resolver) throws -> Any {
        fatalError()
    }
}

// sourcery: AutoMockable
protocol AnyResolver {
    func resolve(_ request: Any) throws -> Any
}

extension AnyResolverMock: Resolver {
    func resolve<Descriptor, Context, Argument>(_ request: InstanceRequest<Descriptor, Context, Argument>) throws -> Descriptor.BaseType where Descriptor: TypeDescriptor {
        try resolve(request as Any) as! Descriptor.BaseType
    }
}

extension AnyScopeMock: Scope {
    typealias Context = Any
}

class DummyScope<Context>: Scope {
    var lock: Lock { fatalError() }
    func registry(for _: Context) -> ScopeRegistry { fatalError() }
}

// sourcery: AutoMockable
protocol AnyBindningMaker {
    func makeBinding(for descriptor: AnyTypeDescriptor) -> Binding
}

extension AnyBindningMakerMock: BindingMaker {
    typealias BoundType = Any

    func makeBinding<Descriptor>(for descriptor: Descriptor) -> Binding where Descriptor: TypeDescriptor {
        makeBinding(for: descriptor as AnyTypeDescriptor)
    }
}

class ReplayLock: Lock {
    var syncCallsCount = 0

    func sync<T>(_ action: () throws -> T) rethrows -> T {
        syncCallsCount += 1
        return try action()
    }
}
