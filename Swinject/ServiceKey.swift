//
//  ServiceKey.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/23/15.
//  Copyright © 2015 DevSwinject. All rights reserved.
//

import Foundation

internal struct ServiceKey {
    private let factoryType: Any.Type
    private let hash: Int
    
    internal init(factoryType: Any.Type) {
        self.factoryType = factoryType
        self.hash = String(factoryType).hashValue
    }
}

// MARK: Hashable
extension ServiceKey: Hashable {
    var hashValue: Int {
        return hash
    }
}

// MARK: Equatable
func ==(lhs: ServiceKey, rhs: ServiceKey) -> Bool {
    return lhs.factoryType == rhs.factoryType
}
