//: # Swinject Sample for iOS

import UIKit
import Swinject

//: ## Basic Use

protocol AnimalType {
    var name: String? { get }
}

class Cat: AnimalType {
    let name: String?
    
    init(name: String?) {
        self.name = name
    }
}

protocol PersonType {
    func play() -> String
}

class PetOwner: PersonType {
    let pet: AnimalType
    
    init(pet: AnimalType) {
        self.pet = pet
    }
    
    func play() -> String {
        let name = pet.name ?? "someone"
        return "I'm playing with \(name)."
    }
}

let container = Container()
container.register(AnimalType.self) { _ in Cat(name: "Mimi") }
container.register(PersonType.self) { r in
    PetOwner(pet: r.resolve(AnimalType.self)!)
}

let person = container.resolve(PersonType.self)!
print(person.play())

