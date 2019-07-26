//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Swinject

class AnimalAssembly: Assembly {
    func assemble(container: Container) {
        container.register(Animal.self) { _ in
            Cat(name: "Whiskers")
        }
    }
}

class FoodAssembly: Assembly {
    func assemble(container: Container) {
        container.register(Food.self) { _ in
            Sushi()
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

class ContainerSpyAssembly: Assembly {
    func assemble(container: Container) {
        container.register(Container.self) { _ in
            container
        }
    }
}
