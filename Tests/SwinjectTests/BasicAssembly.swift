//
//  BasicAssembly.swift
//  Swinject
//
//  Created by mike.owens on 12/9/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Swinject

class AnimalAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(Animal.self) { r in
            return Cat(name: "Whiskers")
        }
    }
}

class FoodAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(Food.self) { r in
            return Sushi()
        }
    }
}

class PersonAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(PetOwner.self) { r in
            let definition = PetOwner()
            definition.favoriteFood = r.resolve(Food.self)
            definition.pet = r.resolve(Animal.self)
            return definition
        }
    }
}
