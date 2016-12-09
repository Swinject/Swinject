//
//  ServiceKey.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/23/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Foundation

// MARK: ServiceKeyOption
public protocol ServiceKeyOption: CustomStringConvertible {
    func isEqualTo(_ another: ServiceKeyOption) -> Bool
    var hashValue: Int { get }
}

// MARK: - ServiceKey
internal struct ServiceKey {
    internal let factoryType: FunctionType.Type
    internal let name: String?
    internal let option: ServiceKeyOption? // Used for SwinjectStoryboard or other extensions.
    
    internal init(factoryType: FunctionType.Type, name: String? = nil, option: ServiceKeyOption? = nil) {
        self.factoryType = factoryType
        self.name = name
        self.option = option
    }
}

// MARK: Hashable
extension ServiceKey: Hashable {
    var hashValue: Int {
        return String(describing: factoryType).hashValue ^ (name?.hashValue ?? 0) ^ (option?.hashValue ?? 0)
    }
}

// MARK: Equatable
func == (lhs: ServiceKey, rhs: ServiceKey) -> Bool {
    return lhs.factoryType == rhs.factoryType && lhs.name == rhs.name && equalOptions(opt1: lhs.option, opt2: rhs.option)
}

private func equalOptions(opt1: ServiceKeyOption?, opt2: ServiceKeyOption?) -> Bool {
    switch (opt1, opt2) {
    case let (opt1?, opt2?): return opt1.isEqualTo(opt2)
    case (nil, nil): return true
    default: return false
    }
}
