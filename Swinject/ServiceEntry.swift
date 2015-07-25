//
//  ServiceEntry.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/24/15.
//  Copyright © 2015 DevSwinject. All rights reserved.
//

import Foundation

internal final class ServiceEntry {
    internal let factory: Any // Must be a function type.
    internal var scope = ObjectScope.None
    internal var instance: AnyObject?
    
    internal init(factory: Any) {
        self.factory = factory
    }
}

extension ServiceEntry : RegistrationType {
    internal func inObjectScope(scope: ObjectScope) {
        self.scope = scope
    }
}
