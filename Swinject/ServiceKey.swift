//
//  ServiceKey.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/23/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Foundation

internal struct ServiceKey {
    private let factoryType: Any.Type
    private let name: String?
    
    internal init(factoryType: Any.Type, name: String? = nil) {
        self.factoryType = factoryType
        self.name = name
    }
}

// MARK: Hashable
extension ServiceKey: Hashable {
    var hashValue: Int {
        return String(factoryType).hashValue ^ (name?.hashValue ?? 0)
    }
}

// MARK: Equatable
func ==(lhs: ServiceKey, rhs: ServiceKey) -> Bool {
    let equalFactoryTypes: Bool
    
#if os(tvOS)
    // Workaround for issue #18.
    //
    // Only in case of tvOS, an instance of a type inheriting AVPlayerViewController does not
    // return `dynamicType` that is equal to the type.
    // To avoid the problem, factory types are compared as strings.
    //
    // If a future version of Xcode fixes the issue, the `#if os(tvOS)` part should be removed
    // because the types should be compared directly.

    equalFactoryTypes = String(reflecting: lhs.factoryType) == String(reflecting: rhs.factoryType)
#else
    equalFactoryTypes = lhs.factoryType == rhs.factoryType
#endif
    
    return equalFactoryTypes && lhs.name == rhs.name
}
