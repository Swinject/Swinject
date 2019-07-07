//
//  CarComputedProperty.swift
//  Swinject
//
//  Created by Oliver Siedler on 06.07.19.
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Foundation

public class CarComputedProperty: NSObject {
    private var _driver: Driver!
    @objc public var driver: Driver! {
        set {
            _driver = newValue
        }
        get {
            return _driver
        }
    }
}
