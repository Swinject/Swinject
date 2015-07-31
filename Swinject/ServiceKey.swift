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
    return lhs.factoryType == rhs.factoryType && lhs.name == rhs.name
}
