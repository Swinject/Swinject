//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Swinject

/*:
 ## Basic Use
 */

protocol Animal {
    var name: String? { get set }
    func sound() -> String
}

class Cat: Animal {
    var name: String?

    init(name: String?) {
        self.name = name
    }

    func sound() -> String {
        return "Meow!"
    }
}

protocol Person {
    func play() -> String
}

class PetOwner: Person {
    let pet: Animal

    init(pet: Animal) {
        self.pet = pet
    }

    func play() -> String {
        let name = pet.name ?? "someone"
        return "I'm playing with \(name). \(pet.sound())"
    }
}

// Create a container and register service and component pairs.
let container = Container()
container.register(Animal.self) { _ in Cat(name: "Mimi") }
container.register(Person.self) { r in PetOwner(pet: r.resolve(Animal.self)!) }

// The person is resolved to a PetOwner with a Cat.
let person = container.resolve(Person.self)!
print(person.play())

/*:
 ## Named Registration
 */

class Dog: Animal {
    var name: String?

    init(name: String?) {
        self.name = name
    }

    func sound() -> String {
        return "Bow wow!"
    }
}

// Add more registrations to the container already containing the PetOwner with the Cat.
container.register(Animal.self, name: "dog") { _ in Dog(name: "Hachi") }
container.register(Person.self, name: "doggy") { r in PetOwner(pet: r.resolve(Animal.self, name: "dog")!) }

// Resolve the service with the registration name to differentiate from the cat owner.
let doggyPerson = container.resolve(Person.self, name: "doggy")!
print(doggyPerson.play())

/*:
 ## Initialization Callback
 */

// A closure can be registered as an initCompleted callback.
var called = false
container.register(Animal.self, name: "cb") { _ in Cat(name: "Mew") }
    .initCompleted { _, _ in called = true }
print(called)

// The closure is executed when the instance is created.
let catWithCallback = container.resolve(Animal.self, name: "cb")
print(called)

/*:
 ## Injection Patterns
 */

class InjectablePerson: Person {
    var pet: Animal? {
        didSet {
            log = "Injected by property."
        }
    }

    var log = ""

    init() {}

    init(pet: Animal) {
        self.pet = pet
        log = "Injected by initializer."
    }

    func setPet(_ pet: Animal) {
        self.pet = pet
        log = "Injected by method."
    }

    func play() -> String {
        return log
    }
}

// Initializer injection
container.register(Person.self, name: "initializer") { r in
    InjectablePerson(pet: r.resolve(Animal.self)!)
}

let initializerInjection = container.resolve(Person.self, name: "initializer")!
print(initializerInjection.play())

// Property injection 1 (in the component factory)
container.register(Person.self, name: "property1") { r in
    let person = InjectablePerson()
    person.pet = r.resolve(Animal.self)
    return person
}

let propertyInjection1 = container.resolve(Person.self, name: "property1")!
print(propertyInjection1.play())

// Property injection 2 (in the initCompleted callback)
container.register(Person.self, name: "property2") { _ in InjectablePerson() }
    .initCompleted { r, p in
        let injectablePerson = p as! InjectablePerson
        injectablePerson.pet = r.resolve(Animal.self)
    }

let propertyInjection2 = container.resolve(Person.self, name: "property2")!
print(propertyInjection2.play())

// Method injection 1 (in the component factory)
container.register(Person.self, name: "method1") { r in
    let person = InjectablePerson()
    person.setPet(r.resolve(Animal.self)!)
    return person
}

let methodInjection1 = container.resolve(Person.self, name: "method1")!
print(methodInjection1.play())

// Method injection 2 (in the initCompleted callback)
container.register(Person.self, name: "method2") { _ in InjectablePerson() }
    .initCompleted { r, p in
        let injectablePerson = p as! InjectablePerson
        injectablePerson.setPet(r.resolve(Animal.self)!)
    }

let methodInjection2 = container.resolve(Person.self, name: "method2")!
print(methodInjection2.play())

/*:
 ## Circular Dependency
 */

internal protocol ParentProtocol: AnyObject {}
internal protocol ChildProtocol: AnyObject {}

internal class Parent: ParentProtocol {
    let child: ChildProtocol?

    init(child: ChildProtocol?) {
        self.child = child
    }
}

internal class Child: ChildProtocol {
    weak var parent: ParentProtocol?
}

// Use initCompleted callback to set the circular dependency to avoid infinite recursion.
container.register(ParentProtocol.self) { r in Parent(child: r.resolve(ChildProtocol.self)!) }
container.register(ChildProtocol.self) { _ in Child() }
    .initCompleted { r, c in
        let child = c as! Child
        child.parent = r.resolve(ParentProtocol.self)
    }

let parent = container.resolve(ParentProtocol.self) as! Parent
let child = parent.child as! Child

// The parent and child are referencing each other.
print(parent === child.parent)

/*:
 ## Injection with Arguments
 */

class Horse: Animal {
    var name: String?
    var running: Bool

    convenience init(name: String) {
        self.init(name: name, running: false)
    }

    init(name: String, running: Bool) {
        self.name = name
        self.running = running
    }

    func sound() -> String {
        return "Whinny!"
    }
}

// The factory closure can take arguments after the `Resolver` parameter (in this example, unused as `_`).
// Note that the container already has an Animal without a registration name,
// but the factory with the arguments is recognized as a different registration to resolve.
container.register(Animal.self) { _, name in Horse(name: name) }
container.register(Animal.self) { _, name, running in Horse(name: name, running: running) }

// The arguments to the factory are specified on the resolution.
// If you pass an argument, pass it to `argument` parameter.
// If you pass more arguments, pass them as a tuple to `arguments` parameter.
let horse1 = container.resolve(Animal.self, argument: "Spirit") as! Horse
print(horse1.name!)
print(horse1.running)

let horse2 = container.resolve(Animal.self, arguments: "Lucky", true) as! Horse
print(horse2.name!)
print(horse2.running)

/*:
 ## Self-binding
 */

protocol MyData {
    var data: String { get }
}

class MyImportantData: MyData {
    let data = "Important data"
}

class MyController {
    var myData: MyData?

    func showData() -> String {
        return myData.map { $0.data } ?? ""
    }
}

// Register MyController as both service and component s to inject dependency to its property.
container.register(MyController.self) { _ in MyController() }
    .initCompleted { r, c in c.myData = r.resolve(MyData.self)! }
container.register(MyData.self) { _ in MyImportantData() }

let myController = container.resolve(MyController.self)!
print(myController.showData())

/*:
 ## Container Hierarchy
 */

let parentContainer = Container()
parentContainer.register(Animal.self, name: "cat") { _ in Cat(name: "Mimi") }

let childContainer = Container(parent: parentContainer)
childContainer.register(Animal.self, name: "dog") { _ in Dog(name: "Hachi") }

// The registration on the parent container is resolved on the child container.
let cat = childContainer.resolve(Animal.self, name: "cat")
print(cat != nil)

// The registration on the child container is not resolved on the parent container.
let dog = parentContainer.resolve(Animal.self, name: "dog")
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

class C {}

//: ### ObjectScope.transient

// New instatnces are created every time.
let container1 = Container()
container1.register(C.self) { _ in C() }
    .inObjectScope(.transient)

let c1 = container1.resolve(C.self)
let c2 = container1.resolve(C.self)
print(c1 !== c2)

// New instances are created in a object graph.
container1.register(A.self) { r in A(b: r.resolve(B.self)!, c: r.resolve(C.self)!) }
container1.register(B.self) { r in B(c: r.resolve(C.self)!) }

let a1 = container1.resolve(A.self)!
print(a1.b.c !== a1.c)

//: ### ObjectScope.graph

// New instances are created like ObjectScope.transient.
let container2 = Container()
container2.register(C.self) { _ in C() }
    .inObjectScope(.graph) // This is the default scope.

let c3 = container2.resolve(C.self)
let c4 = container2.resolve(C.self)
print(c3 !== c4)

// But unlike ObjectScope.transient, the same instance is resolved in the object graph.
container2.register(A.self) { r in A(b: r.resolve(B.self)!, c: r.resolve(C.self)!) }
container2.register(B.self) { r in B(c: r.resolve(C.self)!) }

let a2 = container2.resolve(A.self)!
print(a2.b.c === a2.c)

//: ### ObjectScope.container

// The same instance is shared in the container
let container4 = Container()
container4.register(C.self) { _ in C() }
    .inObjectScope(.container)

let c8 = container4.resolve(C.self)
let c9 = container4.resolve(C.self)
print(c8 === c9)

// The instance in the parent container is shared to its child container.
let childOfContainer4 = Container(parent: container4)
let c10 = childOfContainer4.resolve(C.self)
print(c8 === c10)

/*:
 ## Injection of Value s
 */

struct Turtle: Animal {
    var name: String?

    init(name: String?) {
        self.name = name
    }

    func sound() -> String {
        return "Ninja!"
    }
}

// A value  can be registered as a component.
// The object scope is ignored because a value  always creates a new instance.
let container5 = Container()
container5.register(Animal.self) { _ in Turtle(name: "Reo") }
    .inObjectScope(.container)

var turtle1 = container5.resolve(Animal.self)!
var turtle2 = container5.resolve(Animal.self)!

// Still the  of turtle1 and turtle2 is Animal protocol, they work as value s.
// (Try editing 'var turtle1' to 'let turtle1', then you see a compilation error!)
turtle1.name = "Laph"
print(turtle1.name!)
print(turtle2.name!)
