//
//  Container.TypeForwarding.swift
//  Swinject
//
//  Created by Jakub Vaňo on 15/02/2018.
//  Copyright © 2018 Swinject Contributors. All rights reserved.
//

extension Container {
    public func forward<T, S>(_ type: T.Type, name: String? = nil, to service: ServiceEntry<S>) {
        // TODO: add debug info when forwarding unrelated types
        let key = ServiceKey(
            serviceType: T.self,
            argumentsType: service.argumentsType,
            name: name,
            option: nil
        )
        services[key] = service
    }
}
