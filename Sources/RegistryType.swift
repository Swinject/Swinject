//
//  RegistryType.swift
//  Swinject-iOS
//
//  Created by matsuokah on 2017/08/17.
//  Copyright © 2017年 Swinject Contributors. All rights reserved.
//

import Foundation

/// The `RegistryType` protocol helps to realize specifying the desirable registration without String.
public protocol RegistryType {
    var name: String { get }
}
