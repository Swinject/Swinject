//
//  Lazy.swift
//  Swinject
//
//  Created by Jakub Vaňo on 07/03/2018.
//  Copyright © 2018 Swinject Contributors. All rights reserved.
//

public final class Lazy<Service>: EntryWrapperProtocol {
    private let resolveInstance: () -> Any?

    init<Arguments>(
        container: Container,
        entry: ServiceEntryProtocol,
        invoker: @escaping ((Arguments) -> Any) -> Any
    ) {
        let graphIdentifier = container.currentObjectGraph!
        weak var weakContainer = container
        weak var weakEntry = entry

        self.resolveInstance = {
            guard let container = weakContainer, let entry = weakEntry else { return nil }
            container.restoreObjectGraph(graphIdentifier)
            return container.resolve(entry: entry, invoker: invoker)
        }
    }

    private var _instance: Service?
    public var instance: Service {
        if let instance = _instance {
            return instance
        } else {
            _instance = resolveInstance() as? Service
            return _instance!
        }
    }
}
