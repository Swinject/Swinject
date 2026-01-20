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

    // MARK: Smart Assembly Test Objects

    private final class BaseAssembly: SmartAssembly {
        required init() {}
        func assemble(container: Container) {
            container.register(String.self) { _ in "Base" }
        }
    }

    private final class DependentAssembly: SmartAssembly {
        static var requiredAssemblies: [Assembly.Type] { [BaseAssembly.self] }
        required init() {}
        func assemble(container: Container) {
            container.register(Int.self) { resolver in
                resolver.resolve(String.self) == "Base" ? 42 : 0
            }
        }
    }

    private final class CircularA: SmartAssembly {
        static var requiredAssemblies: [Assembly.Type] { [CircularB.self] }
        required init() {}
        func assemble(container: Container) {}
    }

    private final class CircularB: SmartAssembly {
        static var requiredAssemblies: [SmartAssembly.Type] { [CircularA.self] }
        required init() {}
        func assemble(container: Container) {}
    }

    private final class ClassicOnlyAssembly: Assembly {
        func assemble(container: Container) {
            container.register(Bool.self) { _ in true }
        }
    }

    private final class MultiLevelA: SmartAssembly {
        static var requiredAssemblies: [Assembly.Type] { [MultiLevelB.self] }
        required init() {}
        func assemble(container: Container) {
            container.register(String.self) { _ in "A" }
        }
    }

    private final class MultiLevelB: SmartAssembly {
        static var requiredAssemblies: [Assembly.Type] { [MultiLevelC.self] }
        required init() {}
        func assemble(container: Container) {
            container.register(Int.self) { _ in 99 }
        }
    }

    private final class MultiLevelC: SmartAssembly {
        required init() {}
        func assemble(container: Container) {
            container.register(Double.self) { _ in 3.14 }
        }
    }

    private final class DependsOnClassic: SmartAssembly {
        static var requiredAssemblies: [Assembly.Type] { [ClassicOnlyAssembly.self] }
        required init() {}
        func assemble(container: Container) {
            container.register(String.self) { _ in "Dependent" }
        }
    }

    // MARK: - Assembler with SmartAssembly Tests

    func testSmartModeAutomaticallyInitializesMissingAssemblies() {
        let assembler = Assembler(mode: .smart(initializeMissingAssemblies: true))
        assembler.apply(assembly: DependentAssembly())

        XCTAssertEqual(assembler.resolver.resolve(Int.self), 42)
    }

    func testSmartModeDoesNotAffectClassicAssemblies() {
        let assembler = Assembler(mode: .smart(initializeMissingAssemblies: true))
        assembler.apply(assemblies: [
            ClassicOnlyAssembly(),
            DependentAssembly()
        ])

        XCTAssertEqual(assembler.resolver.resolve(Int.self), 42)
        XCTAssertEqual(assembler.resolver.resolve(Bool.self), true)
    }

    func testClassicModeIgnoresSmartAssemblyDependencies() {
        let assembler = Assembler(mode: .classic)
        assembler.apply(assembly: DependentAssembly())

        XCTAssertEqual(assembler.resolver.resolve(Int.self), 0)
    }

    func testSmartModeDetectsCircularDependencies() {
        let assembler = Assembler(mode: .smart(initializeMissingAssemblies: true))
        assembler.apply(assembly: CircularA())

        XCTAssertNil(assembler.resolver.resolve(String.self))
    }

    func testSmartModeAutoInitializesMissingAssemblies() {
        let assembler = Assembler(mode: .smart(initializeMissingAssemblies: true))
        assembler.apply(assembly: DependentAssembly())
        XCTAssertEqual(assembler.resolver.resolve(Int.self), 42)
    }

    func testSmartModeWithMixedClassicAssemblies() {
        let assembler = Assembler(mode: .smart(initializeMissingAssemblies: true))
        assembler.apply(assemblies: [ClassicOnlyAssembly(), DependentAssembly()])
        XCTAssertEqual(assembler.resolver.resolve(Int.self), 42)
        XCTAssertEqual(assembler.resolver.resolve(Bool.self), true)
    }

    func testSmartModeDoesNotAutoInitializeMissingAssemblies() {
        let assembler = Assembler(mode: .smart(initializeMissingAssemblies: false))
        assembler.apply(assembly: DependentAssembly())

        XCTAssertNil(assembler.resolver.resolve(String.self))
        XCTAssertEqual(assembler.resolver.resolve(Int.self), 0)
    }

    func testSmartModeMultiLevelDependencies() {
        let assembler = Assembler(mode: .smart(initializeMissingAssemblies: true))
        assembler.apply(assembly: MultiLevelA())
        XCTAssertEqual(assembler.resolver.resolve(String.self), "A")
        XCTAssertEqual(assembler.resolver.resolve(Int.self), 99)
        XCTAssertEqual(assembler.resolver.resolve(Double.self), 3.14)
    }

    func testSmartAssemblyDependsOnClassicAssembly() {
        let assembler = Assembler(mode: .smart(initializeMissingAssemblies: true))
        assembler.apply(assembly: DependsOnClassic())

        XCTAssertNil(assembler.resolver.resolve(Bool.self))
        XCTAssertEqual(assembler.resolver.resolve(String.self), "Dependent")
    }

    func testLazyApplicationSmartMode() {
        let assembler = Assembler(mode: .smart(initializeMissingAssemblies: true))
        XCTAssertNil(assembler.resolver.resolve(Int.self))
        assembler.apply(assembly: DependentAssembly())
        XCTAssertEqual(assembler.resolver.resolve(Int.self), 42)

        assembler.apply(assemblies: [ClassicOnlyAssembly()])
        XCTAssertEqual(assembler.resolver.resolve(Bool.self), true)
    }

    func testChildAssemblerSmartMode() {
        let parent = Assembler(mode: .classic)
        let child = Assembler(parentAssembler: parent, mode: .smart(initializeMissingAssemblies: true))
        child.apply(assembly: DependentAssembly())

        XCTAssertEqual(child.resolver.resolve(Int.self), 42)
        XCTAssertNil(parent.resolver.resolve(Int.self)) // Parent does not get child registrations
    }

    func testRepeatedApplicationDoesNotDuplicate() {
        let assembler = Assembler(mode: .smart(initializeMissingAssemblies: true))
        assembler.apply(assembly: DependentAssembly())
        assembler.apply(assembly: DependentAssembly()) // re-apply same assembly

        XCTAssertEqual(assembler.resolver.resolve(Int.self), 42)
    }

    func testNoAssembliesApplied() {
        let assembler = Assembler(mode: .smart(initializeMissingAssemblies: true))
        XCTAssertNil(assembler.resolver.resolve(Int.self))
    }
}
