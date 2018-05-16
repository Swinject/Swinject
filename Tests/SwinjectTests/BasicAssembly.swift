//
//  BasicAssembly.swift
//  Swinject
//
//  Created by mike.owens on 12/9/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Swinject

class AnimalAssembly: Assembly {

    func assemble(container: ContainerProtocol) {
        container.register(Animal.self) { _ in
            return Cat(name: "Whiskers")
        }
    }
}

class FoodAssembly: Assembly {

    func assemble(container: ContainerProtocol) {
        container.register(Food.self) { _ in
            return Sushi()
        }
    }
}

class PersonAssembly: Assembly {

    func assemble(container: ContainerProtocol) {
        container.register(PetOwner.self) { r in
            let definition = PetOwner()
            definition.favoriteFood = r.resolve(Food.self)
            definition.pet = r.resolve(Animal.self)
            return definition
        }
    }
}

class ContainerSpyAssembly: Assembly {
    func assemble(container: ContainerProtocol) {
        container.register(ContainerProtocol.self) { _ in
            return container
        }
    }
}
