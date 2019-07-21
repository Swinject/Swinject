//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

@testable import Swinject

class DummyResolver3: Resolver3 {
    func resolve<Descriptor, Context, Argument>(
        _: InstanceRequest<Descriptor, Context, Argument>
    ) throws -> Descriptor.BaseType where Descriptor: TypeDescriptor {
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
    func makeInstance(arg _: Argument, context: Context, resolver _: Resolver3) throws -> Any {
        fatalError()
    }
}

// sourcery: AutoMockable
protocol AnyResolver3 {
    func resolve(_ request: Any) throws -> Any
}

extension AnyResolver3Mock: Resolver3 {
    func resolve<Descriptor, Context, Argument>(
        _ request: InstanceRequest<Descriptor, Context, Argument>
    ) throws -> Descriptor.BaseType where Descriptor: TypeDescriptor {
        try resolve(request as Any) as! Descriptor.BaseType
    }
}

extension AnyScopeMock: Scope {
    typealias Context = Any
}

class DummyScope<Context>: Scope {
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

// sourcery: AutoMockable
protocol StaticScopeRegistry {
    func instance(key: ScopeRegistryKey) -> Any
    func clear()
}

extension StaticScopeRegistryMock: ScopeRegistry {
    func instance(
        for key: ScopeRegistryKey,
        builder _: () throws -> Any,
        finalizer: (Any) throws -> Void
    ) rethrows -> Any {
        instance(key: key)
    }
}

struct BuilderScopeRegistry: ScopeRegistry {
    func instance(for _: ScopeRegistryKey, builder: () throws -> Any, finalizer: (Any) throws -> Void) rethrows -> Any {
        try builder()
    }

    func clear() {}
}
