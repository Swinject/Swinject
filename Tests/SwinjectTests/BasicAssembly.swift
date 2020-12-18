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


class AnimalTypeIdentifiedAssembly: Assembly {
    func assemble(container: Container) {
        container.register(Animal.self, identifier: AnimalIdentifier.myCat) { _ in
            Cat(name: "Whiskers")
        }
        container.register(Animal.self, identifier: AnimalIdentifier.myOtherCat) { _ in
            Cat(name: "Sylvester")
        }
    }
}
class CatTypeIdentifiedAssembly: Assembly {
    func assemble(container: Container) {
        container.register(Cat.self, identifier: .firstCat) { _ in
            Cat(name: "Whiskers")
        }
        container.register(Cat.self, identifier: .secondCat) { _ in
            Cat(name: "Sylvester")
        }
    }
}
