//
//  AnimalType.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/27/15.
//  Copyright © 2015 DevSwinject. All rights reserved.
//

import Foundation

internal protocol AnimalType { }

internal class Cat: AnimalType {
    var name: String?
    var mature = false
    var favoriteFood: FoodType?
    
    init() {
    }
    
    init(name: String) {
        self.name = name
    }
    
    init(name: String, mature: Bool) {
        self.name = name
        self.mature = mature
    }
}

internal class Dog: AnimalType {
}
