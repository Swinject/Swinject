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
        let injectors = entries.compactMap {
            ($0 as? Binding<Descriptor.BaseType>)?.manipulator as? TypeInjector<Descriptor.BaseType>
        }
        if let injector = injectors.first {
            try injector.inject(instance, using: self)
        } else {
            throw SwinjectError()
        }
    }
}

extension Container: Provider {
    func instance<Descriptor>(_ type: Descriptor) throws -> Descriptor.BaseType where Descriptor : TypeDescriptor {
        let providers = entries.compactMap {
            ($0 as? Binding<Descriptor.BaseType>)?.manipulator as? TypeProvider<Descriptor.BaseType>
        }
        if let provider = providers.first {
            return try provider.instance(using: self)
        } else {
            throw SwinjectError()
        }
    }
}
