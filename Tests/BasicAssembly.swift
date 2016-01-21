//
//  BasicAssembly.swift
//  Swinject
//
//  Created by mike.owens on 12/9/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Swinject

class AnimalAssembly: AssemblyType {
    
    func assemble(container: Container) {
        container.register(AnimalType.self) { r in
            return Cat(name: "Whiskers")
        }
    }
}

class FoodAssembly: AssemblyType {
    
    func assemble(container: Container) {
        container.register(FoodType.self) { r in
            return Sushi()
        }
    }
}

class PersonAssembly: AssemblyType {
    
    func assemble(container: Container) {
        container.register(PetOwner.self) { r in
            let definition = PetOwner()
            definition.favoriteFood = r.resolve(FoodType.self)
            definition.pet = r.resolve(AnimalType.self)
            return definition
        }
    }
}

class PropertyAsssembly: AssemblyType {
    func assemble(container: Container) {
        container.register(AnimalType.self) { r in
            return Cat(name: r.property("test.string")!)
        }
    }
}
