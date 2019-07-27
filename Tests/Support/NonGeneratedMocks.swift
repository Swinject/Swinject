//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

@testable import Swinject

class DummyResolver: Resolver {
    func resolve<Descriptor, Argument>(
        _: InstanceRequest<Descriptor, Argument>
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
    func makeInstance(arg _: Argument, context: Context, resolver _: Resolver) throws -> Any {
        fatalError()
    }
}

// sourcery: AutoMockable
protocol AnyResolver {
    func resolve(_ request: Any) throws -> Any
}

extension AnyResolverMock: Resolver {
    func resolve<Descriptor, Argument>(
        _ request: InstanceRequest<Descriptor, Argument>
    ) throws -> Descriptor.BaseType where Descriptor: TypeDescriptor {
        return try resolve(request as Any) as! Descriptor.BaseType
    }
}

extension AnyScopeMock: Scope {
    typealias Context = Any
}

class DummyScope<Context>: Scope {
    func registry(for _: Context) -> ScopeRegistry { fatalError() }
}

extension BindingMakerMock {
    typealias BoundType = Any
}

// sourcery: AutoMockable
protocol StaticScopeRegistry {
    func instance(key: ScopeRegistryKey) -> Any
    func clear()
}

extension StaticScopeRegistryMock: ScopeRegistry {
    func instance(
        for key: ScopeRegistryKey,
        builder _: () throws -> Reference<Any>,
        finalizer: (Any) throws -> Void
    ) rethrows -> Any {
        return instance(key: key)
    }
}

struct BuilderScopeRegistry: ScopeRegistry {
    func instance(
        for _: ScopeRegistryKey,
        builder: () throws -> Reference<Any>,
        finalizer: (Any) throws -> Void
    ) rethrows -> Any {
        return try builder().currentValue
    }

    func clear() {}
}

extension BindingMock {
    // swiftlint:disable large_tuple
    var instanceReceivedArguments: (arg: Any, context: Any, resolver: Resolver)? {
        return instanceArgContextResolverReceivedArguments
    }
}
