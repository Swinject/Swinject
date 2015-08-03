/*:
# Swinject Sample for iOS
*/

import Swinject

/*:
## Basic Use
*/

protocol AnimalType {
    var name: String? { get }
    func sound() -> String
}

class Cat: AnimalType {
    let name: String?
    
    init(name: String?) {
        self.name = name
    }
    
    func sound() -> String {
        return "Meow!"
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
        return "I'm playing with \(name). \(pet.sound())"
    }
}

// Create a container and register service and component pairs.
let container = Container()
container.register(AnimalType.self) { _ in Cat(name: "Mimi") }
container.register(PersonType.self) { r in PetOwner(pet: r.resolve(AnimalType.self)!) }

// The person is resolved to a PetOwner with a Cat.
let person = container.resolve(PersonType.self)!
print(person.play())

/*:
## Named Registration
*/

class Dog: AnimalType {
    let name: String?
    
    init(name: String?) {
        self.name = name
    }
    
    func sound() -> String {
        return "Bow wow!"
    }
}

// Add more registrations to the container already containing the PetOwner with the Cat.
container.register(AnimalType.self, name: "dog") { _ in Dog(name: "Hachi") }
container.register(PersonType.self, name: "doggy") { r in PetOwner(pet: r.resolve(AnimalType.self, name: "dog")!) }

// Resolve the service with the registration name to differentiate from the cat owner.
let doggyPerson = container.resolve(PersonType.self, name:"doggy")!
print(doggyPerson.play())

