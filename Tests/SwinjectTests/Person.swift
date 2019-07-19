//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Foundation

internal protocol Person {}

internal class PetOwner: Person {
    var pet: Animal?
    var favoriteFood: Food?

    init() {}

    init(pet: Animal) {
        self.pet = pet
    }

    func injectAnimal(_ animal: Animal) {
        pet = animal
    }
}
