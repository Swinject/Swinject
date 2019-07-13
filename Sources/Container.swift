//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public func container(@ModuleBuilder builder: () -> [ModuleEntry]) -> Injector & Provider {
    Container(entries: builder())
}

public func container(@ModuleBuilder builder: () -> ModuleEntry) -> Injector & Provider {
    Container(entries: [builder()])
}

public func container(@ModuleBuilder builder: () -> Void) -> Injector & Provider {
    Container(entries: [])
}

struct Container {
    let entries: [ModuleEntry]
}

extension Container: Injector {
    func inject<Descriptor>(_ instance: Descriptor.BaseType, descriptor: Descriptor) throws where Descriptor : TypeDescriptor {
        let injectors = entries
            .compactMap { $0 as? Binding<Descriptor.BaseType> }
            .filter { $0.descriptor.matches(descriptor) }
            .compactMap { $0.manipulator as? TypeInjector<Descriptor.BaseType> }
        if injectors.isEmpty {
            throw SwinjectError()
        } else {
            try injectors.forEach { try $0.inject(instance, using: self) }
        }
    }
}

extension Container: Provider {
    func instance<Descriptor>(_ descriptor: Descriptor) throws -> Descriptor.BaseType where Descriptor : TypeDescriptor {
        let providers = entries
            .compactMap { $0 as? Binding<Descriptor.BaseType> }
            .filter { $0.descriptor.matches(descriptor) }
            .compactMap { $0.manipulator as? TypeProvider<Descriptor.BaseType> }
        if providers.count != 1 {
            throw SwinjectError()
        } else {
            return try providers[0].instance(using: self)
        }
    }
}
