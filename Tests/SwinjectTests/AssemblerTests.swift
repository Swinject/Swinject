//
//  Copyright © 2021 Swinject Contributors. All rights reserved.
//

import XCTest
@testable import Swinject

class AssemblerTests: XCTestCase {
    // MARK: Assembler basic init

    func testAssemblerCanAssembleSingleContainer() {
        let assembler = Assembler([
            AnimalAssembly(),
        ])
        let cat = assembler.resolver.resolve(Animal.self)
        XCTAssertNotNil(cat)
        XCTAssertEqual(cat!.name, "Whiskers")

        let sushi = assembler.resolver.resolve(Food.self)
        XCTAssertNil(sushi)
    }

    func testAssemblerCanAssembleContainerWithNilParent() {
        let assembler = Assembler(parentAssembler: nil)

        let sushi = assembler.resolver.resolve(Food.self)
        XCTAssertNil(sushi)
    }

    func testAssemblerCanAssembleContainerWithNilParentAndAssemblies() {
        let assembler = Assembler([
            AnimalAssembly(),
        ], parent: nil)
        let cat = assembler.resolver.resolve(Animal.self)
        XCTAssertNotNil(cat)
        XCTAssertEqual(cat!.name, "Whiskers")

        let sushi = assembler.resolver.resolve(Food.self)
        XCTAssertNil(sushi)
    }

    func testAssemblerUsesInjectedDefaultObjectScope() {
        let assembler = Assembler([], parent: nil, defaultObjectScope: ObjectScope.container)

        assembler.apply(assembly: ContainerSpyAssembly())
        let container = assembler.resolver.resolve(Container.self)
        let serviceEntry = container?.register(Animal.self) { _ in Siamese(name: "Siam") }

        XCTAssert(serviceEntry?.objectScope === ObjectScope.container)
    }

    func testAssemblerUsesGraphScopeIfNoDefaultObjectScopeIsInjected() {
        let assembler = Assembler([], parent: nil)

        assembler.apply(assembly: ContainerSpyAssembly())
        let container = assembler.resolver.resolve(Container.self)
        let serviceEntry = container?.register(Animal.self) { _ in Siamese(name: "Siam") }

        XCTAssert(serviceEntry?.objectScope === ObjectScope.graph)
    }

    func testAssemblerCanAssembleMultipleContainers() {
        let assembler = Assembler([
            AnimalAssembly(),
            FoodAssembly(),
        ])
        let cat = assembler.resolver.resolve(Animal.self)
        XCTAssertNotNil(cat)
        XCTAssertEqual(cat!.name, "Whiskers")

        let sushi = assembler.resolver.resolve(Food.self)
        XCTAssertNotNil(sushi)
        XCTAssert(sushi is Sushi)
    }

    func testAssemblerCanAssembleMultipleContainersWithInterDependencies() {
        let assembler = Assembler([
            AnimalAssembly(),
            FoodAssembly(),
            PersonAssembly(),
        ])
        let petOwner = assembler.resolver.resolve(PetOwner.self)
        XCTAssertNotNil(petOwner)

        let cat = petOwner!.pet
        XCTAssertNotNil(cat)
        XCTAssertEqual(cat!.name, "Whiskers")

        let sushi = petOwner!.favoriteFood
        XCTAssertNotNil(sushi)
        XCTAssert(sushi is Sushi)
    }

    func testAssemblerCanAssembleMultipleContainersWithInterDependenciesInAnyOrder() {
        let assembler = Assembler([
            PersonAssembly(),
            AnimalAssembly(),
            FoodAssembly(),
        ])
        let petOwner = assembler.resolver.resolve(PetOwner.self)
        XCTAssertNotNil(petOwner)

        let cat = petOwner!.pet
        XCTAssertNotNil(cat)
        XCTAssertEqual(cat!.name, "Whiskers")

        let sushi = petOwner!.favoriteFood
        XCTAssertNotNil(sushi)
        XCTAssert(sushi is Sushi)
    }

    // MARK: Assembler lazy build

    func testAssemblerAssemblesLazyBuild() {
        let assembler = Assembler([])
        var cat = assembler.resolver.resolve(Animal.self)
        XCTAssertNil(cat)

        assembler.apply(assembly: AnimalAssembly())

        cat = assembler.resolver.resolve(Animal.self)
        XCTAssertNotNil(cat)
        XCTAssertEqual(cat!.name, "Whiskers")
    }

    func testAssemblerCanAssembleSingleLoadAwareContainer() {
        let assembler = Assembler([])
        var cat = assembler.resolver.resolve(Animal.self)
        XCTAssertNil(cat)

        let loadAwareAssembly = LoadAwareAssembly { resolver in
            let cat = resolver.resolve(Animal.self)
            XCTAssertNotNil(cat)
            XCTAssertEqual(cat!.name, "Bojangles")
        }

        XCTAssertFalse(loadAwareAssembly.loaded)
        assembler.apply(assembly: loadAwareAssembly)
        XCTAssert(loadAwareAssembly.loaded)

        cat = assembler.resolver.resolve(Animal.self)
        XCTAssertNotNil(cat)
        XCTAssertEqual(cat!.name, "Bojangles")
    }

    func testAssemblerCanAssembleMultipleContainersOneByOne() {
        let assembler = Assembler([])
        var cat = assembler.resolver.resolve(Animal.self)
        XCTAssertNil(cat)

        var sushi = assembler.resolver.resolve(Food.self)
        XCTAssertNil(sushi)

        assembler.apply(assembly: AnimalAssembly())

        cat = assembler.resolver.resolve(Animal.self)
        XCTAssertNotNil(cat)
        XCTAssertEqual(cat!.name, "Whiskers")

        sushi = assembler.resolver.resolve(Food.self)
        XCTAssertNil(sushi)

        assembler.apply(assembly: FoodAssembly())

        sushi = assembler.resolver.resolve(Food.self)
        XCTAssertNotNil(sushi)
    }

    func testAssemblerCanAssembleMultipleContainersAtOnce() {
        let assembler = Assembler([])
        var cat = assembler.resolver.resolve(Animal.self)
        XCTAssertNil(cat)

        var sushi = assembler.resolver.resolve(Food.self)
        XCTAssertNil(sushi)

        assembler.apply(assemblies: [
            AnimalAssembly(),
            FoodAssembly(),
        ])

        cat = assembler.resolver.resolve(Animal.self)
        XCTAssertNotNil(cat)
        XCTAssertEqual(cat!.name, "Whiskers")

        sushi = assembler.resolver.resolve(Food.self)
        XCTAssertNotNil(sushi)
    }

    // MARK: Assembler load aware

    func testLoadAwareAssemblyCanAssembleSingleContainer() {
        let loadAwareAssembly = LoadAwareAssembly { resolver in
            let cat = resolver.resolve(Animal.self)
            XCTAssertNotNil(cat)
            XCTAssertEqual(cat!.name, "Bojangles")
        }

        XCTAssertFalse(loadAwareAssembly.loaded)
        let assembler = Assembler([
            loadAwareAssembly,
        ])
        XCTAssert(loadAwareAssembly.loaded)

        let cat = assembler.resolver.resolve(Animal.self)
        XCTAssertNotNil(cat)
        XCTAssertEqual(cat!.name, "Bojangles")
    }

    func testLoadAwareAssemblyCanAssembleMultipleContainers() {
        let loadAwareAssembly = LoadAwareAssembly { resolver in
            let cat = resolver.resolve(Animal.self)
            XCTAssertNotNil(cat)
            XCTAssertEqual(cat!.name, "Bojangles")

            let sushi = resolver.resolve(Food.self)
            XCTAssertNotNil(sushi)
        }

        XCTAssertFalse(loadAwareAssembly.loaded)
        let assembler = Assembler([
            loadAwareAssembly,
            FoodAssembly(),
        ])
        XCTAssert(loadAwareAssembly.loaded)

        let cat = assembler.resolver.resolve(Animal.self)
        XCTAssertNotNil(cat)
        XCTAssertEqual(cat!.name, "Bojangles")

        let sushi = assembler.resolver.resolve(Food.self)
        XCTAssertNotNil(sushi)
    }

    // MARK: Empty Assembler

    func testAssemblerCanCreateEmptyAssemblerAndBuildIt() {
        let assembler = Assembler()

        var cat = assembler.resolver.resolve(Animal.self)
        XCTAssertNil(cat)

        assembler.apply(assembly: AnimalAssembly())

        cat = assembler.resolver.resolve(Animal.self)
        XCTAssertNotNil(cat)
        XCTAssertEqual(cat!.name, "Whiskers")
    }

    // MARK: Child Assembler

    func testChildAssemblerCanBeEmpty() {
        let assembler = Assembler([
            AnimalAssembly(),
        ])

        let childAssembler = Assembler(parentAssembler: assembler)

        let cat = assembler.resolver.resolve(Animal.self)
        XCTAssertNotNil(cat)

        let sushi = assembler.resolver.resolve(Food.self)
        XCTAssertNil(sushi)

        let childCat = childAssembler.resolver.resolve(Animal.self)
        XCTAssertNotNil(childCat)

        let childSushi = childAssembler.resolver.resolve(Food.self)
        XCTAssertNil(childSushi)
    }

    func testChildAssemblerCannotGiveEntitiesToParent() {
        let assembler = Assembler()
        let childAssembler = Assembler([
            AnimalAssembly(),
        ], parent: assembler)

        let cat = assembler.resolver.resolve(Animal.self)
        XCTAssertNil(cat)

        let childCat = childAssembler.resolver.resolve(Animal.self)
        XCTAssertNotNil(childCat)
    }

    func testChildAssemblerUsesInjectedDefaultObjectScope() {
        let parentContainer = Container()
        let parentAssembler = Assembler(container: parentContainer)
        let childAssembler = Assembler(parentAssembler: parentAssembler,
                                       defaultObjectScope: ObjectScope.container)

        childAssembler.apply(assembly: ContainerSpyAssembly())
        let container = childAssembler.resolver.resolve(Container.self)
        let serviceEntry = container?.register(Animal.self) { _ in Siamese(name: "Siam") }

        XCTAssert(serviceEntry?.objectScope === ObjectScope.container)
    }

    func testChildAssemblerHasDefaultObjectScopeOfGraphType() {
        let parentContainer = Container()
        let parentAssembler = Assembler(container: parentContainer)
        let childAssembler = Assembler(parentAssembler: parentAssembler)

        childAssembler.apply(assembly: ContainerSpyAssembly())
        let container = childAssembler.resolver.resolve(Container.self)
        let serviceEntry = container?.register(Animal.self) { _ in Siamese(name: "Siam") }

        XCTAssert(serviceEntry?.objectScope === ObjectScope.graph)
    }

    func testChildAssemblerUsesGivenListOfBehaviorsToContainer() {
        let spy = BehaviorSpy()
        let assembler = Assembler(parentAssembler: Assembler(), behaviors: [spy])

        assembler.apply(assembly: ContainerSpyAssembly())

        XCTAssertEqual(spy.entries.count, 1)
    }

    func testChildAssemblerUsesGivenListOfBehaviorsBeforeApplyingAssemblies() {
        let spy = BehaviorSpy()
        _ = Assembler([ContainerSpyAssembly()], parent: Assembler(), behaviors: [spy])

        XCTAssertEqual(spy.entries.count, 1)
    }
}
