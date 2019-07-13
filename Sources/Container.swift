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

extension Container {
    private func bindings<Descriptor>(for descriptor: Descriptor) -> [Binding<Descriptor.BaseType>] where Descriptor : TypeDescriptor {
        return entries
            .compactMap { $0 as? Binding<Descriptor.BaseType> }
            .filter { $0.descriptor.matches(descriptor) }
    }

    private func matches<Descriptor>(_ entry: ModuleEntry, _ descriptor: Descriptor) -> Bool where Descriptor: TypeDescriptor {
        (entry as? Binding<Descriptor.BaseType>)?.descriptor.matches(descriptor) ?? false
    }
}

extension Container: Injector {
    func inject<Descriptor>(_ instance: Descriptor.BaseType, descriptor: Descriptor) throws where Descriptor : TypeDescriptor {
        let injectors = bindings(for: descriptor)
            .compactMap { $0.manipulator as? TypeInjector<Descriptor.BaseType> }
        if injectors.isEmpty {
            throw MissingTypeInjector()
        } else {
            try injectors.forEach { try $0.inject(instance, using: self) }
        }
    }
}

extension Container: Provider {
    func instance<Descriptor, Dependency>(_ descriptor: Descriptor, with dependency: Dependency) throws -> Descriptor.BaseType where Descriptor : TypeDescriptor {
        let providers = bindings(for: descriptor)
            .compactMap { $0.manipulator as? TypeProvider<Descriptor.BaseType> }
        if providers.count != 1 {
            throw SwinjectError()
        } else {
            let instance = try providers[0].instance(using: provider(with: dependency))
            do { try inject(instance, descriptor: descriptor) } catch _ as MissingTypeInjector {}
            return instance
        }
    }

    private func provider<Dependency>(with dependency: Dependency) -> Provider {
        guard !(dependency is Void) else { return self }
        return Container(entries: entries
            .filter { !matches($0, plain(Dependency.self)) }
            + [bind(Dependency.self) & dependency]
        )
    }
}
