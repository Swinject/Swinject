/*:
# Swinject Sample for iOS
*/

import Swinject

/*:
## Basic Use
*/

protocol AnimalType {
    var name: String? { get set }
    func sound() -> String
}

class Cat: AnimalType {
    var name: String?
    
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
    var name: String?
    
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

/*:
## Initialization Callback
*/

// A closure can be registered as an initCompleted callback.
var called = false
container.register(AnimalType.self, name: "cb") { _ in Cat(name: "Mew") }
    .initCompleted { _, _ in called = true }
print(called)

// The closure is executed when the instance is created.
let catWithCallback = container.resolve(AnimalType.self, name: "cb")
print(called)

/*:
## Injection Patterns
*/

class InjectablePerson: PersonType {
    var pet: AnimalType? {
        didSet {
            log = "Injected by property."
        }
    }
    var log = ""
    
    init() { }
    
    init(pet: AnimalType) {
        self.pet = pet
        log = "Injected by initializer."
    }
    
    func setPet(pet: AnimalType) {
        self.pet = pet
        log = "Injected by method."
    }
    
    func play() -> String {
        return log
    }
}

// Initializer injection
container.register(PersonType.self, name: "initializer") { r in
    InjectablePerson(pet: r.resolve(AnimalType.self)!)
}

let initializerInjection = container.resolve(PersonType.self, name:"initializer")!
print(initializerInjection.play())

// Property injection 1 (in the component factory)
container.register(PersonType.self, name: "property1") { r in
    let person = InjectablePerson()
    person.pet = r.resolve(AnimalType.self)
    return person
}

let propertyInjection1 = container.resolve(PersonType.self, name:"property1")!
print(propertyInjection1.play())

// Property injection 2 (in the initCompleted callback)
container.register(PersonType.self, name: "property2") { _ in InjectablePerson() }
    .initCompleted { r, p in
        let injectablePerson = p as! InjectablePerson
        injectablePerson.pet = r.resolve(AnimalType.self)
    }

let propertyInjection2 = container.resolve(PersonType.self, name:"property2")!
print(propertyInjection2.play())

// Method injection 1 (in the component factory)
container.register(PersonType.self, name: "method1") { r in
    let person = InjectablePerson()
    person.setPet(r.resolve(AnimalType.self)!)
    return person
}

let methodInjection1 = container.resolve(PersonType.self, name:"method1")!
print(methodInjection1.play())

// Method injection 2 (in the initCompleted callback)
container.register(PersonType.self, name: "method2") { _ in InjectablePerson() }
    .initCompleted { r, p in
        let injectablePerson = p as! InjectablePerson
        injectablePerson.setPet(r.resolve(AnimalType.self)!)
    }

let methodInjection2 = container.resolve(PersonType.self, name:"method2")!
print(methodInjection2.play())

/*:
## Circular Dependency
*/

internal protocol ParentType: AnyObject { }
internal protocol ChildType: AnyObject { }

internal class Mother: ParentType {
    let child: ChildType?
    
    init(child: ChildType?) {
        self.child = child
    }
}

internal class Daughter: ChildType {
    weak var parent: ParentType?
}

// Use initCompleted callback to set the circular dependency to avoid infinite recursion.
container.register(ParentType.self) { r in Mother(child: r.resolve(ChildType.self)!) }
container.register(ChildType.self) { _ in Daughter() }
    .initCompleted { r, c in
        let daughter = c as! Daughter
        daughter.parent = r.resolve(ParentType.self)
    }

let mother = container.resolve(ParentType.self) as! Mother
let daughter = mother.child as! Daughter

// The mother and daughter are referencing each other.
print(mother === daughter.parent)

/*:
## Injection with Arguments
*/

class Horse: AnimalType {
    var name: String?
    var running = false
    
    init(name: String, running: Bool) {
        self.name = name
        self.running = running
    }
    
    func sound() -> String {
        return "Whinny!"
    }
}

// The factory closure can take arguments.
// Note that the container already has an AnimalType without a registration name,
// but the factory with the arguments is recognized as a different registration to resolve.
container.register(AnimalType.self) { _, arg1, arg2 in Horse(name: arg1, running: arg2) }

// The arguments to the factory are specified on the resolution.
let horse = container.resolve(AnimalType.self, arg1: "Lucky", arg2: true) as! Horse
print(horse.name!)
print(horse.running)

/*:
## Self-binding
*/

class SelfieBoy {
    func takePhoto() -> String {
        return "Selfie!"
    }
}

// Register SelfieBoy as both service and component types.
container.register(SelfieBoy.self) { r in SelfieBoy() }

let selfieBoy = container.resolve(SelfieBoy.self)!
print(selfieBoy.takePhoto())

/*:
## Container Hierarchy
*/

let parentContainer = Container()
parentContainer.register(AnimalType.self, name: "cat") { _ in Cat(name: "Mimi") }

let childContainer = Container(parent: parentContainer)
childContainer.register(AnimalType.self, name: "dog") { _ in Dog(name: "Hachi") }

// The registration on the parent container is resolved on the child container.
let cat = childContainer.resolve(AnimalType.self, name: "cat")
print(cat != nil)

// The registration on the child container is not resolved on the parent container.
let dog = parentContainer.resolve(AnimalType.self, name: "dog")
print(dog == nil)

/*:
## Object Scopes
*/

class A {
    let b: B
    let c: C
    
    init(b: B, c: C) {
        self.b = b
        self.c = c
    }
}

class B {
    let c: C
    
    init(c: C) {
        self.c = c
    }
}

class C { }

//: ### ObjectScope.None (aka Transient)

// New instatnces are created every time.
let container1 = Container()
container1.register(C.self) { _ in C() }
    .inObjectScope(.None)

let c1 = container1.resolve(C.self)
let c2 = container1.resolve(C.self)
print(c1 !== c2)

// New instances are created in a object graph.
container1.register(A.self) { r in A(b: r.resolve(B.self)!, c: r.resolve(C.self)!) }
container1.register(B.self) { r in B(c: r.resolve(C.self)!) }

let a1 = container1.resolve(A.self)!
print(a1.b.c !== a1.c)

//: ### ObjectScope.Graph

// New instances are created like ObjectScope.None.
let container2 = Container()
container2.register(C.self) { _ in C() }
    .inObjectScope(.Graph) // This is the default scope.

let c3 = container2.resolve(C.self)
let c4 = container2.resolve(C.self)
print(c3 !== c4)

// But unlike ObjectScope.None, the same instance is resolved in the object graph.
container2.register(A.self) { r in A(b: r.resolve(B.self)!, c: r.resolve(C.self)!) }
container2.register(B.self) { r in B(c: r.resolve(C.self)!) }

let a2 = container2.resolve(A.self)!
print(a2.b.c === a2.c)

//: ### ObjectScope.Container (aka Singleton)

// The same instance is shared in the container.
let container3 = Container()
container3.register(C.self) { _ in C() }
    .inObjectScope(.Container)

let c5 = container3.resolve(C.self)
let c6 = container3.resolve(C.self)
print(c5 === c6)

// The instance in the parent container is not shared to its child container.
let childOfContainer3 = Container(parent: container3)
let c7 = childOfContainer3.resolve(C.self)
print(c5 !== c7)

//: ### ObjectScope.Hierarchy (aka Singleton in the Hierarchy)

// The same instance is shared in the container like ObjectScope.Container.
let container4 = Container()
container4.register(C.self) { _ in C() }
    .inObjectScope(.Hierarchy)

let c8 = container4.resolve(C.self)
let c9 = container4.resolve(C.self)
print(c8 === c9)

// Unlike ObjectScope.Container, the instance in the parent container is shared to its child container.
let childOfContainer4 = Container(parent: container4)
let c10 = childOfContainer4.resolve(C.self)
print(c8 === c10)

/*:
## Injection of Value Types
*/

struct Turtle: AnimalType {
    var name: String?
    
    init(name: String?) {
        self.name = name
    }
    
    func sound() -> String {
        return "Ninja!"
    }
}

// A value type can be registered as a component.
// The object scope is ignored because a value type always creates a new instance.
let container5 = Container()
container5.register(AnimalType.self) { _ in Turtle(name: "Reo") }
    .inObjectScope(.Container)

var turtle1 = container5.resolve(AnimalType.self)!
var turtle2 = container5.resolve(AnimalType.self)!

// Still the type of turtle1 and turtle2 is AnimalType protocol, they work as value types.
// (Try editing 'var turtle1' to 'let turtle1', then you see a compilation error!)
turtle1.name = "Laph"
print(turtle1.name!)
print(turtle2.name!)

/*:
## Shared Singleton Container
*/

// The shared container can be used if it is ok to depend on the singleton container.
Container.defaultContainer.register(AnimalType.self) { _ in Cat(name: "Mew") }

let mew = Container.defaultContainer.resolve(AnimalType.self)!
print(mew.name!)

