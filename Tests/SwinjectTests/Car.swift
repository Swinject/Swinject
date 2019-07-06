//
//  Car.swift
//  Swinject-iOS
//
//  Created by Oliver Siedler on 06.07.19.
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Foundation

public class Car: NSObject {
    public var driver: Driver!

    @objc public func setDriver(_ driver: NSObject) {
        self.driver = driver as? Driver
    }
}
