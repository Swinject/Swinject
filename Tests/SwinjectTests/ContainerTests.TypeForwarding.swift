//
//  Copyright © 2021 Swinject Contributors. All rights reserved.
//

import XCTest
@testable import Swinject

class ContainerTests_TypeForwarding: XCTestCase {
    var container: Container!

    override func setUpWithError() throws {
        container = Container()
    }

    // MARK: Container method

    func testContainerResolvesForwardedType() {
        let service = container.register(Dog.self) { _ in Dog() }
        container.forward(Animal.self, to: service)

        let animal = container.resolve(Animal.self)

        XCTAssertNotNil(animal)
    }

    func testContainerResolvesForwardedTypeWithArguments() {
        let service = container.register(Cat.self) { _, name, sleeping in Cat(name: name, sleeping: sleeping) }
        container.forward(Animal.self, to: service)

        let animal = container.resolve(Animal.self, arguments: "Mimi", true) as? Cat

        XCTAssertEqual(animal?.name, "Mimi")
        XCTAssert(animal?.sleeping == true)
    }

    func testContainerResolvesForwardedTypeGivenCorrectName() {
        let service = container.register(Dog.self) { _ in Dog() }
        container.forward(Animal.self, name: "Hachi", to: service)

        let animal = container.resolve(Animal.self, name: "Hachi")

        XCTAssertNotNil(animal)
    }

    func testContainerDoesNotResolveForwardedTypeGivenIncorrectName() {
        let service = container.register(Dog.self) { _ in Dog() }
        container.forward(Animal.self, name: "Hachi", to: service)

        let animal = container.resolve(Animal.self, name: "Mimi")

        XCTAssertNil(animal)
    }

    func testContainerDoesNotResolveWhenForwardingIncompatibleTypes() {
        let service = container.register(Dog.self) { _ in Dog() }
        container.forward(Cat.self, to: service)

        let cat = container.resolve(Cat.self)

        XCTAssertNil(cat)
    }

    func testContainerDoesNotResolveWhenForwardingIncompatibleTypesWithArguments() {
        let service = container.register(Dog.self) { (_, _: String) in Dog() }
        container.forward(Cat.self, to: service)

        let cat = container.resolve(Cat.self, argument: "")

        XCTAssertNil(cat)
    }

    func testContainerResolvesForwardedTypeEvenIfOnlyImplementationTypeConformsToIt() {
        let service = container.register(Animal.self) { _ in Dog() }
        container.forward(Dog.self, to: service)
        let dog = container.resolve(Dog.self)
        XCTAssertNotNil(dog)
    }

    // MARK: Service entry method

    func testContainerResolvesForwardedTypeWithServiceEntry() {
        container.register(Dog.self) { _ in Dog() }
            .implements(Animal.self)

        let animal = container.resolve(Animal.self)

        XCTAssertNotNil(animal)
    }

    func testContainerSuportsMultipleForwardingDefinitions() {
        container.register(Dog.self) { _ in Dog() }
            .implements(DogProtocol1.self)
            .implements(DogProtocol2.self)
            .implements(DogProtocol3.self)

        let dog1 = container.resolve(DogProtocol1.self)
        let dog2 = container.resolve(DogProtocol2.self)
        let dog3 = container.resolve(DogProtocol3.self)

        XCTAssertNotNil(dog1)
        XCTAssertNotNil(dog2)
        XCTAssertNotNil(dog3)
    }

    func testContainerResolvesForwardedTypesOnlyWhenCorrectNameIsGiven() {
        container.register(Dog.self) { _ in Dog() }
            .implements(DogProtocol1.self, name: "1")
            .implements(DogProtocol2.self, name: "2")
            .implements(DogProtocol3.self, name: "3")

        let dog1 = container.resolve(DogProtocol1.self, name: "1")
        let dog2 = container.resolve(DogProtocol2.self)
        let dog3 = container.resolve(DogProtocol3.self, name: "2")

        XCTAssertNotNil(dog1)
        XCTAssertNil(dog2)
        XCTAssertNil(dog3)
    }

    func testContainerSupportsDefiningMultipleTypesAtOnce() {
        container.register(Dog.self) { _ in Dog() }
            .implements(DogProtocol1.self, DogProtocol2.self, DogProtocol3.self)

        let dog1 = container.resolve(DogProtocol1.self)
        let dog2 = container.resolve(DogProtocol2.self)
        let dog3 = container.resolve(DogProtocol3.self)

        XCTAssertNotNil(dog1)
        XCTAssertNotNil(dog2)
        XCTAssertNotNil(dog3)
    }

    // MARK: Optional resolving

    func testContainerResolvesOptionalWhenWrappedTypeIsRegistered() {
        container.register(Dog.self) { _ in Dog() }
        let optionalDog = container.resolve(Dog?.self)
        XCTAssertNotNil(optionalDog ?? nil)
    }

    func testContainerResolvesOptionalToNilWhenWrappedTypeIsNotRegistered() {
        let optionalDog = container.resolve(Dog?.self)
        XCTAssertNotNil(optionalDog)
    }

    func testContainerResolvesOptionalWithName() {
        container.register(Dog.self, name: "Hachi") { _ in Dog() }
        let optionalDog = container.resolve(Dog?.self, name: "Hachi")
        XCTAssertNotNil(optionalDog ?? nil)
    }

    func testContainerResolvesOptionalToNilWithWrongName() {
        container.register(Dog.self, name: "Hachi") { _ in Dog() }
        let optionalDog = container.resolve(Dog?.self, name: "Mimi")
        XCTAssertNil(optionalDog ?? nil)
        XCTAssertNotNil(optionalDog)
    }

    func testContainerResolvesOptionalWithArguments() {
        container.register(Dog.self) { _, name in Dog(name: name) }
        let optionalDog = container.resolve(Dog?.self, argument: "Hachi")
        XCTAssertNotNil(optionalDog ?? nil)
    }

    func testContainerResolvesOptionalOfFowrardedType() {
        container.register(Dog.self) { _ in Dog() }.implements(Animal.self)
        let optionalAnimal = container.resolve(Animal?.self)
        let unwrappedAnimal = container.resolve(Animal?.self)
        XCTAssertNotNil(optionalAnimal ?? nil)
        XCTAssertNotNil(unwrappedAnimal ?? nil)
    }
}

private protocol DogProtocol1 {}
private protocol DogProtocol2 {}
private protocol DogProtocol3 {}
extension Dog: DogProtocol1, DogProtocol2, DogProtocol3 {}
