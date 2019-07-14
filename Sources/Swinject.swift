//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct Swinject {
    let entries: [SwinjectEntry]

    init(entries: [SwinjectEntry]) {
        self.entries = entries
    }
}

public extension Swinject {
    init(@SwinjectTreeBuilder builder: () -> [SwinjectEntry]) {
        self.init(entries: builder())
    }

    init(@SwinjectTreeBuilder builder: () -> SwinjectEntry) {
        self.init(entries: [builder()])
    }

    init(@SwinjectTreeBuilder builder: () -> Void) {
        self.init(entries: [])
    }
}

extension Swinject {
    private func entries<Descriptor>(for descriptor: Descriptor) -> [BindingEntry<Descriptor.BaseType>] where Descriptor : TypeDescriptor {
        return entries
            .compactMap { $0 as? BindingEntry<Descriptor.BaseType> }
            .filter { $0.descriptor.matches(descriptor) }
    }

    private func matches<Descriptor>(_ entry: SwinjectEntry, _ descriptor: Descriptor) -> Bool where Descriptor: TypeDescriptor {
        (entry as? BindingEntry<Descriptor.BaseType>)?.descriptor.matches(descriptor) ?? false
    }
}

extension Swinject: Injector {
    public func instance<Descriptor, Dependency>(_ descriptor: Descriptor, with dependency: Dependency) throws -> Descriptor.BaseType where Descriptor : TypeDescriptor {
        let matchingEntries = entries(for: descriptor)
        if matchingEntries.count != 1 {
            throw SwinjectError()
        } else {
            return try matchingEntries[0].binding.instance(using: provider(with: dependency)) as! Descriptor.BaseType
        }
    }

    private func provider<Dependency>(with dependency: Dependency) -> Injector {
        guard !(dependency is Void) else { return self }
        return Swinject(entries: entries
            .filter { !matches($0, plain(Dependency.self)) }
            + [bind(Dependency.self) & dependency]
        )
    }
}
