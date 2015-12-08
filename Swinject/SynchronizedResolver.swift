//
//  SynchronizedResolver.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 11/23/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

internal final class SynchronizedResolver {
    internal let container: Container
    
    internal init(container: Container) {
        self.container = container
    }
}

extension SynchronizedResolver: Resolvable {
    internal func resolve<Service>(serviceType: Service.Type) -> Service? {
        return container.lock.sync {
            return self.container.resolve(serviceType)
        }
    }
    
    internal func resolve<Service>(serviceType: Service.Type, name: String?) -> Service? {
        return container.lock.sync {
            return self.container.resolve(serviceType, name: name)
        }
    }
}
