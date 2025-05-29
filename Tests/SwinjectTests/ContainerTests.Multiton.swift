//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import XCTest
@testable import Swinject

class ContainerTests_Multiton: XCTestCase {
    var container: Container!

    override func setUp() {
        super.setUp()
        container = Container()
    }

    // MARK: Multiton scope tests
    
    func testMultitonScopeReturnsSameInstanceForSameArguments() {
        container.register(Animal.self) { _, name in
            Cat(name: name)
        }
        .inObjectScope(.multiton)
        
        let cat1 = container.resolve(Animal.self, argument: "Mimi") as? Cat
        let cat2 = container.resolve(Animal.self, argument: "Mimi") as? Cat
        let cat3 = container.resolve(Animal.self, argument: "Mew") as? Cat
        
        XCTAssertTrue(cat1 === cat2)
        XCTAssertTrue(cat1 !== cat3)
        XCTAssertEqual(cat1?.name, "Mimi")
        XCTAssertEqual(cat3?.name, "Mew")
    }
    
    func testMultitonScopeWithMultipleArguments() {
        container.register(Person.self) { _, firstName, lastName in
            PetOwner2(firstName: firstName, lastName: lastName)
        }
        .inObjectScope(.multiton)
        
        let person1 = container.resolve(Person.self, arguments: "John", "Doe") as? PetOwner2
        let person2 = container.resolve(Person.self, arguments: "John", "Doe") as? PetOwner2
        let person3 = container.resolve(Person.self, arguments: "Jane", "Doe") as? PetOwner2
        let person4 = container.resolve(Person.self, arguments: "John", "Smith") as? PetOwner2
        
        XCTAssertTrue(person1 === person2)
        XCTAssertTrue(person1 !== person3)
        XCTAssertTrue(person1 !== person4)
        XCTAssertTrue(person3 !== person4)
        
        XCTAssertEqual(person1?.firstName, "John")
        XCTAssertEqual(person1?.lastName, "Doe")
        XCTAssertEqual(person3?.firstName, "Jane")
        XCTAssertEqual(person3?.lastName, "Doe")
        XCTAssertEqual(person4?.firstName, "John")
        XCTAssertEqual(person4?.lastName, "Smith")
    }
    
    func testMultitonScopeWithComplexArguments() {
        struct Config: Hashable {
            let id: Int
            let name: String
        }
        
        container.register(Animal.self) { (_, config: Config) in
            Cat(name: config.name)
        }
        .inObjectScope(.multiton)
        
        let config1 = Config(id: 1, name: "Mimi")
        let config2 = Config(id: 1, name: "Mimi")
        let config3 = Config(id: 2, name: "Mew")
        
        let cat1 = container.resolve(Animal.self, argument: config1) as? Cat
        let cat2 = container.resolve(Animal.self, argument: config2) as? Cat
        let cat3 = container.resolve(Animal.self, argument: config3) as? Cat
        
        XCTAssertTrue(cat1 === cat2)
        XCTAssertTrue(cat1 !== cat3)
    }
    
    func testMultitonScopeResetClearsCache() {
        container.register(Animal.self) { _, name in
            Cat(name: name)
        }
        .inObjectScope(.multiton)
        
        let cat1 = container.resolve(Animal.self, argument: "Mimi") as? Cat
        container.resetObjectScope(.multiton)
        let cat2 = container.resolve(Animal.self, argument: "Mimi") as? Cat
        
        XCTAssertTrue(cat1 !== cat2)
        XCTAssertEqual(cat1?.name, cat2?.name)
    }
    
    func testMultitonScopeWithNoArguments() {
        // Multiton with no arguments should behave like container scope
        container.register(Animal.self) { _ in
            Cat(name: "Default")
        }
        .inObjectScope(.multiton)
        
        let cat1 = container.resolve(Animal.self) as? Cat
        let cat2 = container.resolve(Animal.self) as? Cat
        
        XCTAssertTrue(cat1 === cat2)
    }
}

// Helper class for testing
private class PetOwner2: Person {
    let firstName: String
    let lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func play() {
        // Implementation not needed for tests
    }
} 