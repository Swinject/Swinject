//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import XCTest
@testable import Swinject

class ContainerTests: XCTestCase {
    var container: Container!

    override func setUpWithError() throws {
        container = Container()
    }

    // MARK: Resolution of a non-registered service

    func testContainerReturnsNilWithoutRegistration() {
        let animal = container.resolve(Animal.self)
        XCTAssertNil(animal)
    }

    // MARK: Resolution of the same service

    func testContainerResolvesByArguments() {
        container.register(Animal.self) { _ in Cat() }
        container.register(Animal.self) { _, arg in Cat(name: arg) }
        container.register(Animal.self) { _, arg1, arg2 in Cat(name: arg1, sleeping: arg2) }

        let noname = container.resolve(Animal.self) as? Cat
        let mimi = container.resolve(Animal.self, argument: "Mimi") as? Cat
        let mew = container.resolve(Animal.self, arguments: "Mew", true) as? Cat
        XCTAssertNil(noname?.name)
        XCTAssertEqual(mimi?.name, "Mimi")
        XCTAssertEqual(mew?.name, "Mew")
        XCTAssert(mew?.sleeping == true)
    }

    func testContainerResolvesByRegisteredName() {
        container.register(Animal.self, name: "RegMimi") { _ in Cat(name: "Mimi") }
        container.register(Animal.self, name: "RegMew") { _ in Cat(name: "Mew") }
        container.register(Animal.self) { _ in Cat() }

        let mimi = container.resolve(Animal.self, name: "RegMimi") as? Cat
        let mew = container.resolve(Animal.self, name: "RegMew") as? Cat
        let noname = container.resolve(Animal.self) as? Cat
        XCTAssertEqual(mimi?.name, "Mimi")
        XCTAssertEqual(mew?.name, "Mew")
        XCTAssertNil(noname?.name)
    }

    // MARK: Removal of registered services

    func testContainerCanRemoveAllRegisteredServices() {
        container.register(Animal.self, name: "RegMimi") { _ in Cat(name: "Mimi") }
        container.register(Animal.self, name: "RegMew") { _ in Cat(name: "Mew") }
        container.removeAll()

        let mimi = container.resolve(Animal.self, name: "RegMimi")
        let mew = container.resolve(Animal.self, name: "RegMew")
        XCTAssertNil(mimi)
        XCTAssertNil(mew)
    }

    // MARK: Container hierarchy

    func testContainerResolvesServiceRegisteredOnParentContainer() {
        let parent = Container()
        let child = Container(parent: parent)

        parent.register(Animal.self) { _ in Cat() }
        let cat = child.resolve(Animal.self)
        XCTAssertNotNil(cat)
    }

    func testContainerDoesNotResolveServiceRegistredOnChildContainer() {
        let parent = Container()
        let child = Container(parent: parent)

        child.register(Animal.self) { _ in Cat() }
        let cat = parent.resolve(Animal.self)
        XCTAssertNil(cat)
    }

    func testContainerDoesNotCreateZombies() {
        let parent = Container()
        let child = Container(parent: parent)

        parent.register(Cat.self) { _ in Cat() }
        weak var weakCat = child.resolve(Cat.self)
        XCTAssertNil(weakCat)
    }

    func testShadowedRegistration_receiverHierarchyAccess() {
        let parent = Container()
        let child = Container(parent: parent, resolverHierarchyAccess: .receiver)

        parent.register(Animal.self, factory: { _ in Dog()})
        child.register(Animal.self, factory: { _ in Cat()})

        parent.register(Animal.self, name: "Spot", factory: { resolver in
            resolver.resolve(Animal.self)!
        })

        XCTAssert(child.resolve(Animal.self, name: "Spot") is Cat)
        XCTAssert(parent.resolve(Animal.self, name: "Spot") is Dog)
    }

    func testShadowedRegistration_receiverHierarchyAccess_inObjectScopeContainer() {
        let parent = Container()
        let child = Container(parent: parent, resolverHierarchyAccess: .receiver)

        parent.register(Animal.self, factory: { _ in Dog()})
        child.register(Animal.self, factory: { _ in Cat()})

        parent.register(Animal.self, name: "Spot", factory: { resolver in
            resolver.resolve(Animal.self)!
        })
        .inObjectScope(.container)

        XCTAssert(child.resolve(Animal.self, name: "Spot") is Cat)
        // The instance provided by the child leaks into the parent
        XCTAssert(parent.resolve(Animal.self, name: "Spot") is Cat)
    }

    func testShadowedRegistration_owningContainerHierarchyAccess() {
        let parent = Container()
        let child = Container(parent: parent, resolverHierarchyAccess: .owningContainer)

        parent.register(Animal.self, factory: { _ in Dog()})
        child.register(Animal.self, factory: { _ in Cat()})

        parent.register(Animal.self, name: "Spot", factory: { resolver in
            resolver.resolve(Animal.self)!
        })

        XCTAssert(child.resolve(Animal.self, name: "Spot") is Dog)
        XCTAssert(parent.resolve(Animal.self, name: "Spot") is Dog)
    }

    func testShadowedRegistration_owningContainerHierarchyAccess_inObjectScopeContainer() {
        let parent = Container()
        let child = Container(parent: parent, resolverHierarchyAccess: .owningContainer)

        parent.register(Animal.self, factory: { _ in Dog()})
        child.register(Animal.self, factory: { _ in Cat()})

        parent.register(Animal.self, name: "Spot", factory: { resolver in
            resolver.resolve(Animal.self)!
        })
        .inObjectScope(.container)

        XCTAssert(child.resolve(Animal.self, name: "Spot") is Dog)
        XCTAssert(parent.resolve(Animal.self, name: "Spot") is Dog)
    }

    #if !SWIFT_PACKAGE
    func testContainerDoesNotTerminateGraphPrematurely() {
        let parent = Container()
        let child = Container(parent: parent)

        child.register(Animal.self) { _ in Cat() }
        parent.register(Food.self) { _ in Sushi() }
        parent.register(PetOwner.self) {
            let owner = PetOwner(pet: child.resolve(Animal.self)!)
            owner.favoriteFood = $0.resolve(Food.self)
            return owner
        }

        // Make sure no assertion happens by the resolution below
        _ = parent.resolve(PetOwner.self)
    }
    #endif

    // MARK: Scope

    private func registerCatAndPetOwnerDependingOnFood(_ container: Container) {
        container.register(Animal.self) {
            let cat = Cat()
            cat.favoriteFood = $0.resolve(Food.self)
            return cat
        }
        container.register(Person.self) {
            let owner = PetOwner(pet: $0.resolve(Animal.self)!)
            owner.favoriteFood = $0.resolve(Food.self)
            return owner
        }
    }

    // MARK: Scope - Transient

    func testContainerDoesNotHaveSharedObjectInContainerWithTransientScope() {
        container.register(Animal.self) { _ in Cat() }
            .inObjectScope(.transient)

        let cat1 = container.resolve(Animal.self) as? Cat
        let cat2 = container.resolve(Animal.self) as? Cat
        XCTAssert(cat1 !== cat2)
    }

    func testContainerResolvesServiceToNewObjectsInGraphWithTransientScope() {
        registerCatAndPetOwnerDependingOnFood(container)
        container.register(Food.self) { _ in Sushi() }
            .inObjectScope(.transient)

        let owner = container.resolve(Person.self) as? PetOwner
        let ownersSushi = owner?.favoriteFood as? Sushi
        let catsSushi = (owner?.pet as? Cat)?.favoriteFood as? Sushi
        XCTAssert(ownersSushi !== catsSushi)
    }

    // MARK: Scope - Graph

    func testContainerDoesNotHaveSharedObjectInContainerWithGraphScope() {
        container.register(Animal.self) { _ in Cat() }
            .inObjectScope(.graph)

        let cat1 = container.resolve(Animal.self) as? Cat
        let cat2 = container.resolve(Animal.self) as? Cat
        XCTAssert(cat1 !== cat2)
    }

    func testContainerResolvesServiceToTheSameObjectInGraphWithGraphScope() {
        registerCatAndPetOwnerDependingOnFood(container)
        container.register(Food.self) { _ in Sushi() }
            .inObjectScope(.graph)

        let owner = container.resolve(Person.self) as? PetOwner
        let ownersSushi = owner?.favoriteFood as? Sushi
        let catsSushi = (owner?.pet as? Cat)?.favoriteFood as? Sushi
        XCTAssert(ownersSushi === catsSushi)
    }

    // MARK: Scope - Container

    func testContainerSharesObjectInTheOwnContainerWithContainerScope() {
        container.register(Animal.self) { _ in Cat() }
            .inObjectScope(.container)

        let cat1 = container.resolve(Animal.self) as? Cat
        let cat2 = container.resolve(Animal.self) as? Cat
        XCTAssert(cat1 === cat2)
    }

    func testContainerSharesObjectFromParentContainerToItsChildWithContainerScope() {
        let parent = Container()
        parent.register(Animal.self) { _ in Cat() }
            .inObjectScope(.container)
        parent.register(Animal.self, name: "dog") { _ in Dog() }
            .inObjectScope(.container)
        let child = Container(parent: parent)

        // Case resolving on the parent first.
        let cat1 = parent.resolve(Animal.self) as? Cat
        let cat2 = child.resolve(Animal.self) as? Cat
        XCTAssert(cat1 === cat2)

        // Case resolving on the child first.
        let dog1 = child.resolve(Animal.self, name: "dog") as? Dog
        let dog2 = parent.resolve(Animal.self, name: "dog") as? Dog
        XCTAssert(dog1 === dog2)
    }

    func testContainerResolvesServiceInParentContainerToTheSameObjectInGraphWithContainerScope() {
        let parent = Container()
        parent.register(Food.self) { _ in Sushi() }
            .inObjectScope(.container)
        let child = Container(parent: parent)
        registerCatAndPetOwnerDependingOnFood(child)

        let owner = child.resolve(Person.self) as? PetOwner
        let ownersSushi = owner?.favoriteFood as? Sushi
        let catsSushi = (owner?.pet as? Cat)?.favoriteFood as? Sushi
        XCTAssert(ownersSushi === catsSushi)
    }

    // MARK: Scope - Weak

    func testContainerSharesObjectInContainerWithWeakScope() {
        container.register(Animal.self) { _ in Cat() }
            .inObjectScope(.weak)

        let cat1 = container.resolve(Animal.self) as? Cat
        let cat2 = container.resolve(Animal.self) as? Cat
        XCTAssertNotNil(cat1)
        XCTAssert(cat1 === cat2)
    }

    func testContainerDoesNotMaintainStrongReferenceToObjectWithWeakScope() {
        container.register(Animal.self) { _ in Cat() }
            .inObjectScope(.weak)

        weak var cat = container.resolve(Animal.self) as? Cat
        XCTAssertNil(cat)
    }

    // MARK: Init completed event

    func testContainerRaisesInitCompletedEventWhenNewInstanceIsCreated() {
        var eventRaised = false
        container.register(Animal.self) { _ in Cat() }
            .initCompleted { _, _ in eventRaised = true }

        let cat = container.resolve(Animal.self)
        XCTAssertNotNil(cat)
        XCTAssert(eventRaised)
    }

    // MARK: Multiple init completed event

    func testContainerRaisesInitCompletedEventForAllSubscribedClosuresWhenNewInstanceIsCreated() {
        var eventsRaised = 0
        container.register(Animal.self) { _ in Cat() }
            .initCompleted { _, _ in eventsRaised += 1 }
            .initCompleted { _, _ in eventsRaised += 1 }
            .initCompleted { _, _ in eventsRaised += 1 }
            .initCompleted { _, _ in eventsRaised += 1 }

        let cat = container.resolve(Animal.self)
        XCTAssertNotNil(cat)
        XCTAssertEqual(eventsRaised, 4)
    }

    // MARK: Injection types

    func testContainerAcceptsInitializerInjection() {
        container.register(Animal.self) { _ in Cat() }
        container.register(Person.self) { r in PetOwner(pet: r.resolve(Animal.self)!) }

        let owner = container.resolve(Person.self) as? PetOwner
        XCTAssertNotNil(owner?.pet)
    }

    func testContainerAfcceptsPropertyInjectionInRegistration() {
        container.register(Animal.self) { _ in Cat() }
        container.register(Person.self) { r in
            let owner = PetOwner()
            owner.pet = r.resolve(Animal.self)!
            return owner
        }

        let owner = container.resolve(Person.self) as? PetOwner
        XCTAssertNotNil(owner?.pet)
    }

    func testContainerAcceptsPropertyInjectionInInitCompletedEvent() {
        container.register(Animal.self) { _ in Cat() }
        container.register(Person.self) { _ in PetOwner() }
            .initCompleted { r, s in
                let owner = s as? PetOwner
                owner?.pet = r.resolve(Animal.self)!
            }

        let owner = container.resolve(Person.self) as? PetOwner
        XCTAssertNotNil(owner?.pet)
    }

    func testContainerAcceptsMethodInjectionInRegistration() {
        container.register(Animal.self) { _ in Cat() }
        container.register(Person.self) { r in
            let owner = PetOwner()
            owner.injectAnimal(r.resolve(Animal.self)!)
            return owner
        }

        let owner = container.resolve(Person.self) as? PetOwner
        XCTAssertNotNil(owner?.pet)
    }

    func testContainerAcceptsMethodInjectionInInitCompletedEvent() {
        container.register(Animal.self) { _ in Cat() }
        container.register(Person.self) { _ in PetOwner() }
            .initCompleted { r, s in
                let owner = s as? PetOwner
                owner?.injectAnimal(r.resolve(Animal.self)!)
            }

        let owner = container.resolve(Person.self) as? PetOwner
        XCTAssertNotNil(owner?.pet)
    }

    // MARK: Value type resolution

    func testContainerResolvesStructInstancesIgnoringObjectScopes() {
        func runIn(scope: ObjectScope) {
            container.removeAll()
            container.register(Animal.self) { _ in Turtle(name: "Ninja") }
                .inObjectScope(scope)
            var turtle1 = container.resolve(Animal.self)!
            let turtle2 = container.resolve(Animal.self)!
            turtle1.name = "Samurai"
            XCTAssertEqual(turtle1.name, "Samurai")
            XCTAssertEqual(turtle2.name, "Ninja")
        }

        runIn(scope: .transient)
        runIn(scope: .graph)
        runIn(scope: .container)
    }

    func testContainerResolvesStructInstancesDefinedInParentContainerIgnoringObjectScopes() {
        func runIn(scope: ObjectScope) {
            container.removeAll()
            container.register(Animal.self) { _ in Turtle(name: "Ninja") }
                .inObjectScope(scope)
            let childContainer = Container(parent: container)

            var turtle1 = childContainer.resolve(Animal.self)!
            let turtle2 = childContainer.resolve(Animal.self)!
            turtle1.name = "Samurai"
            XCTAssertEqual(turtle1.name, "Samurai")
            XCTAssertEqual(turtle2.name, "Ninja")
        }

        runIn(scope: .transient)
        runIn(scope: .graph)
        runIn(scope: .container)
    }

    func testContainerResolvesOnlyOnceToSimulateSingletonIfObjectScopeIsContainerOrHierarchy() {
        func runIn(scope: ObjectScope, expectation: Int) {
            var invokedCount = 0
            container.removeAll()
            container.register(Animal.self) { _ in
                invokedCount += 1
                return Turtle(name: "Ninja")
            }.inObjectScope(scope)
            _ = container.resolve(Animal.self)!
            _ = container.resolve(Animal.self)!
            XCTAssertEqual(invokedCount, expectation)
        }

        runIn(scope: .transient, expectation: 2)
        runIn(scope: .graph, expectation: 2)
        runIn(scope: .container, expectation: 1)
    }

    // MARK: Class as a service type

    func testContainerResolvesRegistredSubclassOfServiceYypeClass() {
        container.register(Cat.self) { _ in Siamese(name: "Siam") }

        let siam = container.resolve(Cat.self) as? Siamese
        XCTAssertEqual(siam?.name, "Siam")
    }

    func testContainerResolvesSelfBindingWithDependencyInjected() {
        container.register(PetOwner.self) { r in PetOwner(pet: r.resolve(Animal.self)!) }
        container.register(Animal.self) { _ in Siamese(name: "Siam") }

        let owner = container.resolve(PetOwner.self)!
        let siam = owner.pet as? Siamese
        XCTAssertEqual(siam?.name, "Siam")
    }

    // MARK: Convenience initializers

    func testContainerTakesClosureRegisteringServices() {
        let container = Container {
            $0.register(Animal.self) { _ in Cat() }
        }

        XCTAssertNotNil(container.resolve(Animal.self) as? Cat)
    }

    // MARK: Default object scope

    func testContainerRegistersServiceWithGivenObjectScope() {
        let container = Container(parent: nil, debugHelper: LoggingDebugHelper(), defaultObjectScope: .weak, resolverHierarchyAccess: .receiver)

        let serviceEntry = container.register(Animal.self) { _ in Siamese(name: "Siam") }
        XCTAssert(serviceEntry.objectScope === ObjectScope.weak)
    }

    // MARK: Has Registration

    func testContainerHasRegistration() {
        let container = Container {
            $0.register(Animal.self) { _ in Cat() }
            $0.register(Food.self, name: "Sushi") { _ in Sushi() }
        }

        XCTAssertTrue(container.hasAnyRegistration(of: Animal.self))
        XCTAssertFalse(container.hasAnyRegistration(of: PetOwner.self))

        XCTAssertTrue(container.hasAnyRegistration(of: Food.self, name: "Sushi"))
        XCTAssertFalse(container.hasAnyRegistration(of: Food.self, name: "Pizza"))
        XCTAssertFalse(container.hasAnyRegistration(of: Food.self))
    }
}
