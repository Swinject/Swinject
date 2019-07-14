//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct Swinject {
    let entries: [ModuleEntry]

    init(entries: [ModuleEntry]) {
        self.entries = entries
    }
}

public extension Swinject {
    init(@ModuleBuilder builder: () -> [ModuleEntry]) {
        self.init(entries: builder())
    }

    init(@ModuleBuilder builder: () -> ModuleEntry) {
        self.init(entries: [builder()])
    }

    init(@ModuleBuilder builder: () -> Void) {
        self.init(entries: [])
    }
}

extension Swinject {
    private func bindings<Descriptor>(for descriptor: Descriptor) -> [Binding<Descriptor.BaseType>] where Descriptor : TypeDescriptor {
        return entries
            .compactMap { $0 as? Binding<Descriptor.BaseType> }
            .filter { $0.descriptor.matches(descriptor) }
    }

    private func matches<Descriptor>(_ entry: ModuleEntry, _ descriptor: Descriptor) -> Bool where Descriptor: TypeDescriptor {
        (entry as? Binding<Descriptor.BaseType>)?.descriptor.matches(descriptor) ?? false
    }
}

extension Swinject: Provider {
    public func instance<Descriptor, Dependency>(_ descriptor: Descriptor, with dependency: Dependency) throws -> Descriptor.BaseType where Descriptor : TypeDescriptor {
        let providers = bindings(for: descriptor)
            .compactMap { $0.manipulator as? TypeProvider<Descriptor.BaseType> }
        if providers.count != 1 {
            throw SwinjectError()
        } else {
            return try providers[0].instance(using: provider(with: dependency))
        }
    }

    private func provider<Dependency>(with dependency: Dependency) -> Provider {
        guard !(dependency is Void) else { return self }
        return Swinject(entries: entries
            .filter { !matches($0, plain(Dependency.self)) }
            + [bind(Dependency.self) & dependency]
        )
    }
}
