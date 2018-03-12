//
//  Lazy.swift
//  Swinject
//
//  Created by Jakub Vaňo on 07/03/2018.
//  Copyright © 2018 Swinject Contributors. All rights reserved.
//

public final class Lazy<Service>: InstanceWrapper {
    static var wrappedType: Any.Type { return Service.self }

    private let factory: () -> Any?
    private let graphIdentifier: GraphIdentifier?
    private weak var container: Container?

    init(inContainer container: Container, withInstanceFactory factory: @escaping () -> Any?) {
        self.factory = factory
        self.graphIdentifier = container.currentObjectGraph
        self.container = container
    }

    private var _instance: Service?
    public var instance: Service {
        if let instance = _instance {
            return instance
        } else {
            _instance = makeInstance()
            return _instance!
        }
    }

    private func makeInstance() -> Service? {
        guard let container = container else {
            return nil
        }
        if let graphIdentifier = graphIdentifier {
            container.restoreObjectGraph(graphIdentifier)
        }
        return factory() as? Service
    }
}
