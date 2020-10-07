//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class ContainerSpec: QuickSpec {
    override func spec() {
        var container: Container!
        beforeEach {
            container = Container()
        }

        describe("Resolution of a non-registered service") {
            it("returns nil.") {
                let animal = container.resolve(Animal.self)
                expect(animal).to(beNil())
            }
        }
        describe("Resolution of the same service") {
            it("resolves by arguments.") {
                container.register(Animal.self) { _ in Cat() }
                container.register(Animal.self) { _, arg in Cat(name: arg) }
                container.register(Animal.self) { _, arg1, arg2 in Cat(name: arg1, sleeping: arg2) }

                let noname = container.resolve(Animal.self) as? Cat
                let mimi = container.resolve(Animal.self, argument: "Mimi") as? Cat
                let mew = container.resolve(Animal.self, arguments: "Mew", true) as? Cat
                expect(noname?.name).to(beNil())
                expect(mimi?.name) == "Mimi"
                expect(mew?.name) == "Mew"
                expect(mew?.sleeping) == true
            }
            it("resolves by the registered name.") {
                container.register(Animal.self, name: "RegMimi") { _ in Cat(name: "Mimi") }
                container.register(Animal.self, name: "RegMew") { _ in Cat(name: "Mew") }
                container.register(Animal.self) { _ in Cat() }

                let mimi = container.resolve(Animal.self, name: "RegMimi") as? Cat
                let mew = container.resolve(Animal.self, name: "RegMew") as? Cat
                let noname = container.resolve(Animal.self) as? Cat
                expect(mimi?.name) == "Mimi"
                expect(mew?.name) == "Mew"
                expect(noname?.name).to(beNil())
            }
        }
        describe("Removal of registered services") {
            it("can remove all registered services.") {
                container.register(Animal.self, name: "RegMimi") { _ in Cat(name: "Mimi") }
                container.register(Animal.self, name: "RegMew") { _ in Cat(name: "Mew") }
                container.removeAll()

                let mimi = container.resolve(Animal.self, name: "RegMimi")
                let mew = container.resolve(Animal.self, name: "RegMew")
                expect(mimi).to(beNil())
                expect(mew).to(beNil())
            }
        }
        describe("Container hierarchy") {
            var child: Container!
            var parent: Container!
            beforeEach {
                parent = Container()
                child = Container(parent: parent)
            }
            it("resolves a service registered on the parent container.") {
                parent.register(Animal.self) { _ in Cat() }
                let cat = child.resolve(Animal.self)
                expect(cat).notTo(beNil())
            }
            it("does not resolve a service registred on the child container.") {
                child.register(Animal.self) { _ in Cat() }
                let cat = parent.resolve(Animal.self)
                expect(cat).to(beNil())
            }
            it("does not create zombies") {
                parent.register(Cat.self) { _ in Cat() }
                weak var weakCat = child.resolve(Cat.self)
                expect(weakCat).to(beNil())
            }
            #if !SWIFT_PACKAGE
                it("does not terminate graph prematurely") {
                    child.register(Animal.self) { _ in Cat() }
                    parent.register(Food.self) { _ in Sushi() }
                    parent.register(PetOwner.self) {
                        let owner = PetOwner(pet: child.resolve(Animal.self)!)
                        owner.favoriteFood = $0.resolve(Food.self)
                        return owner
                    }

                    let expectation: Expectation<Void> = expect {
                        _ = parent.resolve(PetOwner.self)
                    }
                    expectation.notTo(throwAssertion())
                }
            #endif
        }
        describe("Scope") {
            let registerCatAndPetOwnerDependingOnFood: (Container) -> Void = {
                $0.register(Animal.self) {
                    let cat = Cat()
                    cat.favoriteFood = $0.resolve(Food.self)
                    return cat
                }
                $0.register(Person.self) {
                    let owner = PetOwner(pet: $0.resolve(Animal.self)!)
                    owner.favoriteFood = $0.resolve(Food.self)
                    return owner
                }
            }

            context("in transient scope") {
                it("does not have a shared object in a container.") {
                    container.register(Animal.self) { _ in Cat() }
                        .inObjectScope(.transient)

                    let cat1 = container.resolve(Animal.self) as? Cat
                    let cat2 = container.resolve(Animal.self) as? Cat
                    expect(cat1 !== cat2).to(beTrue()) // Workaround for crash in Nimble.
                }
                it("resolves a service to new objects in a graph") {
                    registerCatAndPetOwnerDependingOnFood(container)
                    container.register(Food.self) { _ in Sushi() }
                        .inObjectScope(.transient)

                    let owner = container.resolve(Person.self) as? PetOwner
                    let ownersSushi = owner?.favoriteFood as? Sushi
                    let catsSushi = (owner?.pet as? Cat)?.favoriteFood as? Sushi
                    expect(ownersSushi !== catsSushi).to(beTrue()) // Workaround for crash in Nimble.
                }
            }
            context("in graph scope") {
                it("does not have a shared object in a container.") {
                    container.register(Animal.self) { _ in Cat() }
                        .inObjectScope(.graph)

                    let cat1 = container.resolve(Animal.self) as? Cat
                    let cat2 = container.resolve(Animal.self) as? Cat
                    expect(cat1 !== cat2).to(beTrue()) // Workaround for crash in Nimble.
                }
                it("resolves a service to the same object in a graph") {
                    registerCatAndPetOwnerDependingOnFood(container)
                    container.register(Food.self) { _ in Sushi() }
                        .inObjectScope(.graph)

                    let owner = container.resolve(Person.self) as? PetOwner
                    let ownersSushi = owner?.favoriteFood as? Sushi
                    let catsSushi = (owner?.pet as? Cat)?.favoriteFood as? Sushi
                    expect(ownersSushi === catsSushi).to(beTrue()) // Workaround for crash in Nimble.
                }
            }
            context("in container scope") {
                it("shares an object in the own container.") {
                    container.register(Animal.self) { _ in Cat() }
                        .inObjectScope(.container)

                    let cat1 = container.resolve(Animal.self) as? Cat
                    let cat2 = container.resolve(Animal.self) as? Cat
                    expect(cat1 === cat2).to(beTrue()) // Workaround for crash in Nimble.
                }
                it("shares an object from a parent container to its child.") {
                    let parent = Container()
                    parent.register(Animal.self) { _ in Cat() }
                        .inObjectScope(.container)
                    parent.register(Animal.self, name: "dog") { _ in Dog() }
                        .inObjectScope(.container)
                    let child = Container(parent: parent)

                    // Case resolving on the parent first.
                    let cat1 = parent.resolve(Animal.self) as? Cat
                    let cat2 = child.resolve(Animal.self) as? Cat
                    expect(cat1 === cat2).to(beTrue()) // Workaround for crash in Nimble.

                    // Case resolving on the child first.
                    let dog1 = child.resolve(Animal.self, name: "dog") as? Dog
                    let dog2 = parent.resolve(Animal.self, name: "dog") as? Dog
                    expect(dog1 === dog2).to(beTrue()) // Workaround for crash in Nimble.
                }
                it("resolves a service in the parent container to the same object in a graph") {
                    let parent = Container()
                    parent.register(Food.self) { _ in Sushi() }
                        .inObjectScope(.container)
                    let child = Container(parent: parent)
                    registerCatAndPetOwnerDependingOnFood(child)

                    let owner = child.resolve(Person.self) as? PetOwner
                    let ownersSushi = owner?.favoriteFood as? Sushi
                    let catsSushi = (owner?.pet as? Cat)?.favoriteFood as? Sushi
                    expect(ownersSushi === catsSushi).to(beTrue()) // Workaround for crash in Nimble.
                }
            }
            context("in weak scope") {
                it("shares the object in the container") {
                    container.register(Animal.self) { _ in Cat() }
                        .inObjectScope(.weak)

                    let cat1 = container.resolve(Animal.self) as? Cat
                    let cat2 = container.resolve(Animal.self) as? Cat
                    expect(cat1).notTo(beNil())
                    expect(cat1 === cat2).to(beTrue()) // Workaround for crash in Nimble.
                }
                it("does not maintain a strong reference to the object") {
                    container.register(Animal.self) { _ in Cat() }
                        .inObjectScope(.weak)

                    weak var cat = container.resolve(Animal.self) as? Cat
                    expect(cat).to(beNil())
                }
            }
        }
        describe("Init completed event") {
            it("raises the event when a new instance is created.") {
                var eventRaised = false
                container.register(Animal.self) { _ in Cat() }
                    .initCompleted { _, _ in eventRaised = true }

                let cat = container.resolve(Animal.self)
                expect(cat).notTo(beNil())
                expect(eventRaised) == true
            }
        }
        describe("Multiple init completed event") {
            it("raises the event for all subscribed closures when a new instance is created.") {
                var eventsRaised = 0
                container.register(Animal.self) { _ in Cat() }
                    .initCompleted { _, _ in eventsRaised += 1 }
                    .initCompleted { _, _ in eventsRaised += 1 }
                    .initCompleted { _, _ in eventsRaised += 1 }
                    .initCompleted { _, _ in eventsRaised += 1 }

                let cat = container.resolve(Animal.self)
                expect(cat).notTo(beNil())
                expect(eventsRaised) == 4
            }
        }
        describe("Injection types") {
            it("accepts initializer injection.") {
                container.register(Animal.self) { _ in Cat() }
                container.register(Person.self) { r in PetOwner(pet: r.resolve(Animal.self)!) }

                let owner = container.resolve(Person.self) as? PetOwner
                expect(owner?.pet).notTo(beNil())
            }
            it("accepts property injection in registration.") {
                container.register(Animal.self) { _ in Cat() }
                container.register(Person.self) { r in
                    let owner = PetOwner()
                    owner.pet = r.resolve(Animal.self)!
                    return owner
                }

                let owner = container.resolve(Person.self) as? PetOwner
                expect(owner?.pet).notTo(beNil())
            }
            it("accepts property injection in initCompleted event.") {
                container.register(Animal.self) { _ in Cat() }
                container.register(Person.self) { _ in PetOwner() }
                    .initCompleted { r, s in
                        let owner = s as? PetOwner
                        owner?.pet = r.resolve(Animal.self)!
                    }

                let owner = container.resolve(Person.self) as? PetOwner
                expect(owner?.pet).notTo(beNil())
            }
            it("accepts method injection in registration.") {
                container.register(Animal.self) { _ in Cat() }
                container.register(Person.self) { r in
                    let owner = PetOwner()
                    owner.injectAnimal(r.resolve(Animal.self)!)
                    return owner
                }

                let owner = container.resolve(Person.self) as? PetOwner
                expect(owner?.pet).notTo(beNil())
            }
            it("accepts method injection in initCompleted event.") {
                container.register(Animal.self) { _ in Cat() }
                container.register(Person.self) { _ in PetOwner() }
                    .initCompleted { r, s in
                        let owner = s as? PetOwner
                        owner?.injectAnimal(r.resolve(Animal.self)!)
                    }

                let owner = container.resolve(Person.self) as? PetOwner
                expect(owner?.pet).notTo(beNil())
            }
        }
        describe("Value type resolution") {
            it("resolves struct instances ignoring object scopes.") {
                let runInObjectScope: (ObjectScope) -> Void = { scope in
                    container.removeAll()
                    container.register(Animal.self) { _ in Turtle(name: "Ninja") }
                        .inObjectScope(scope)
                    var turtle1 = container.resolve(Animal.self)!
                    let turtle2 = container.resolve(Animal.self)!
                    turtle1.name = "Samurai"
                    expect(turtle1.name) == "Samurai"
                    expect(turtle2.name) == "Ninja"
                }

                runInObjectScope(.transient)
                runInObjectScope(.graph)
                runInObjectScope(.container)
            }
            it("resolves struct instances defined in the parent container ignoring object scopes.") {
                let runInObjectScope: (ObjectScope) -> Void = { scope in
                    container.removeAll()
                    container.register(Animal.self) { _ in Turtle(name: "Ninja") }
                        .inObjectScope(scope)
                    let childContainer = Container(parent: container)

                    var turtle1 = childContainer.resolve(Animal.self)!
                    let turtle2 = childContainer.resolve(Animal.self)!
                    turtle1.name = "Samurai"
                    expect(turtle1.name) == "Samurai"
                    expect(turtle2.name) == "Ninja"
                }

                runInObjectScope(.transient)
                runInObjectScope(.graph)
                runInObjectScope(.container)
            }
            context("object scope is container or hierarchy") {
                it("resolves only once to simulate singleton (instantiation only once).") {
                    let runInObjectScope: (ObjectScope, Int) -> Void = { scope, expectation in
                        var invokedCount = 0
                        container.removeAll()
                        container.register(Animal.self) { _ in
                            invokedCount += 1
                            return Turtle(name: "Ninja")
                        }.inObjectScope(scope)
                        _ = container.resolve(Animal.self)!
                        _ = container.resolve(Animal.self)!
                        expect(invokedCount) == expectation
                    }

                    runInObjectScope(.transient, 2)
                    runInObjectScope(.graph, 2)
                    runInObjectScope(.container, 1)
                }
            }
        }
        describe("Class as a service type") {
            it("resolves a registred subclass of a service type class.") {
                container.register(Cat.self) { _ in Siamese(name: "Siam") }

                let siam = container.resolve(Cat.self) as? Siamese
                expect(siam?.name) == "Siam"
            }
            it("resolves a self-binding with dependency injected.") {
                container.register(PetOwner.self) { r in PetOwner(pet: r.resolve(Animal.self)!) }
                container.register(Animal.self) { _ in Siamese(name: "Siam") }

                let owner = container.resolve(PetOwner.self)!
                let siam = owner.pet as? Siamese
                expect(siam?.name) == "Siam"
            }
        }
        describe("Convenience initializers") {
            it("takes a closure registering services.") {
                let container = Container {
                    $0.register(Animal.self) { _ in Cat() }
                }

                expect(container.resolve(Animal.self) as? Cat).notTo(beNil())
            }
        }
        describe("Default object scope") {
            it("registers services with given object scope") {
                let container = Container(parent: nil, debugHelper: LoggingDebugHelper(), defaultObjectScope: .weak)

                let serviceEntry = container.register(Animal.self) { _ in Siamese(name: "Siam") }
                expect(serviceEntry.objectScope) === ObjectScope.weak
            }
        }
    }
}
