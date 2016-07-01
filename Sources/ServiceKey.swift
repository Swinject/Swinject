//
//  ServiceKey.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/23/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Foundation

// MARK: ServiceKeyOptionType
public protocol ServiceKeyOptionType: CustomStringConvertible {
    func isEqualTo(another: ServiceKeyOptionType) -> Bool
    var hashValue: Int { get }
}

// MARK: - ServiceKey
internal struct ServiceKey {
    internal let factoryType: FunctionType.Type
    internal let name: String?
    internal let option: ServiceKeyOptionType? // Used for SwinjectStoryboard or other extensions.
    
    internal init(factoryType: FunctionType.Type, name: String? = nil, option: ServiceKeyOptionType? = nil) {
        self.factoryType = factoryType
        self.name = name
        self.option = option
    }
}

// MARK: Hashable
extension ServiceKey: Hashable {
    var hashValue: Int {
        return String(factoryType).hashValue ^ (name?.hashValue ?? 0) ^ (option?.hashValue ?? 0)
    }
}

// MARK: Equatable
func == (lhs: ServiceKey, rhs: ServiceKey) -> Bool {
    return lhs.factoryType == rhs.factoryType && lhs.name == rhs.name && equalOptions(opt1: lhs.option, opt2: rhs.option)
}

private func equalOptions(opt1 opt1: ServiceKeyOptionType?, opt2: ServiceKeyOptionType?) -> Bool {
    switch (opt1, opt2) {
    case let (opt1?, opt2?): return opt1.isEqualTo(opt2)
    case (nil, nil): return true
    default: return false
    }
}
