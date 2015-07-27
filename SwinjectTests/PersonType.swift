//
//  PersonType.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/27/15.
//  Copyright © 2015 DevSwinject. All rights reserved.
//

import Foundation

internal protocol PersonType { }

internal class PetOwner : PersonType {
    var favoriteAnimal: AnimalType?
    
    init() {
    }
    
    init(favoriteAnimal: AnimalType) {
        self.favoriteAnimal = favoriteAnimal
    }
}
