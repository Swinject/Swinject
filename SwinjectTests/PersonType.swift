//
//  PersonType.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/27/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Foundation

internal protocol PersonType { }

internal class PetOwner: PersonType {
    var pet: AnimalType?
    var favoriteFood: FoodType?
    
    init() {
    }
    
    init(pet: AnimalType) {
        self.pet = pet
    }
    
    func injectAnimal(animal: AnimalType) {
        self.pet = animal
    }
}
