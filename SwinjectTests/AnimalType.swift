//
//  AnimalType.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/27/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Foundation

internal protocol AnimalType {
    var name: String? { get set }
}

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

internal class Siamese: Cat {
}

internal class Dog: AnimalType {
    var name: String?
    
    init() {
    }
    
    init(name: String) {
        self.name = name
    }
}

internal struct Turtle: AnimalType {
    var name: String?
}
