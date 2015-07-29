//
//  PersonType.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/27/15.
//  Copyright © 2015 DevSwinject. All rights reserved.
//

import Foundation

internal protocol PersonType { }

internal class PetOwner: PersonType {
    var pet: AnimalType?
    var house: HouseType?
    
    init() {
    }
    
    init(pet: AnimalType) {
        self.pet = pet
    }
    
    func injectAnimal(animal: AnimalType) {
        self.pet = animal
    }
}
