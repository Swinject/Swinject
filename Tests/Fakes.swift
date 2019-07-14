//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

@testable import Swinject

class FakeInjector: Injector {
    func instance<Descriptor>(_: Descriptor) throws -> Descriptor.BaseType where Descriptor: TypeDescriptor {
        fatalError()
    }
}

class IntBinding: Binding {
    func instance(using _: Injector) throws -> Int { 0 }
}

class IntDescriptor: TypeDescriptor {
    typealias BaseType = Int

    func matches<Descriptor>(_: Descriptor) -> Bool where Descriptor: TypeDescriptor {
        false
    }
}

struct DummyBindingEntry: AnyBindingEntry {
    var binding: AnyBinding { fatalError() }
    var descriptor: AnyTypeDescriptor { fatalError() }
}

struct DummyIncludeEntry: ModuleIncludeEntry {}

class FakeBinding<Type>: Binding {
    var instance: Type
    var error: Error?
    var instanceRequestCount = 0

    init(_ instance: Type) {
        self.instance = instance
    }

    func instance(using _: Injector) throws -> Type {
        instanceRequestCount += 1
        if let error = error { throw error }
        return instance
    }
}

class FakeDescriptor<BaseType>: TypeDescriptor {
    var shouldMatch: (Any) -> Bool = { _ in false }

    func matches<Descriptor>(_ other: Descriptor) -> Bool where Descriptor: TypeDescriptor {
        return shouldMatch(other)
    }
}
