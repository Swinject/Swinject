//
//  Copyright © 2021 Swinject Contributors. All rights reserved.
//

import XCTest
@testable import Swinject

// MARK: Option

private struct Option: ServiceKeyOption {
    let option: Int

    func isEqualTo(_ another: ServiceKeyOption) -> Bool {
        guard let another = another as? Option else {
            return false
        }

        return option == another.option
    }

    func hash(into hasher: inout Hasher) {
        option.hash(into: &hasher)
    }

    var description: String {
        return ""
    }
}

// MARK: ServiceKeySpec

class ServiceKeyTests: XCTestCase {
    // MARK: Without name

    func testServiceKeyEqualsWithTheSameFactoryType() {
        let key1 = ServiceKey(serviceType: Animal.self, argumentsType: Resolver.self)
        let key2 = ServiceKey(serviceType: Animal.self, argumentsType: Resolver.self)
        XCTAssertEqual(key1, key2)
        XCTAssertEqual(key1.hashValue, key2.hashValue)

        let key3 = ServiceKey(serviceType: Animal.self, argumentsType: (Resolver, String, Bool).self)
        let key4 = ServiceKey(serviceType: Animal.self, argumentsType: (Resolver, String, Bool).self)
        XCTAssertEqual(key3, key4)
        XCTAssertEqual(key3.hashValue, key4.hashValue)
    }

    func testServiceKeyDoesNotEqualWithDifferentServiceTypesInFactoryTypes() {
        let key1 = ServiceKey(serviceType: Person.self, argumentsType: Resolver.self)
        let key2 = ServiceKey(serviceType: Animal.self, argumentsType: Resolver.self)
        XCTAssertNotEqual(key1, key2)
        XCTAssertNotEqual(key1.hashValue, key2.hashValue)
    }

    func testServiceKeyDoesNotEqualWithDifferentArgTypesInFactoryTypes() {
        let key1 = ServiceKey(serviceType: Animal.self, argumentsType: (Resolver, String).self)
        let key2 = ServiceKey(serviceType: Animal.self, argumentsType: (Resolver, String, Bool).self)
        XCTAssertNotEqual(key1, key2)
        XCTAssertNotEqual(key1.hashValue, key2.hashValue)

        let key3 = ServiceKey(serviceType: Animal.self, argumentsType: (Resolver, String, Bool).self)
        let key4 = ServiceKey(serviceType: Animal.self, argumentsType: (Resolver, String, Int).self)
        XCTAssertNotEqual(key3, key4)
        XCTAssertNotEqual(key3.hashValue, key4.hashValue)
    }

    // MARK: With name

    func testServiceKeyEqualsWithTheSameName() {
        let key1 = ServiceKey(serviceType: Animal.self, argumentsType: Resolver.self, name: "my factory")
        let key2 = ServiceKey(serviceType: Animal.self, argumentsType: Resolver.self, name: "my factory")
        XCTAssertEqual(key1, key2)
        XCTAssertEqual(key1.hashValue, key2.hashValue)

        let key3 = ServiceKey(
            serviceType: Animal.self,
            argumentsType: (Resolver, String, Bool).self,
            name: "my factory"
        )
        let key4 = ServiceKey(
            serviceType: Animal.self,
            argumentsType: (Resolver, String, Bool).self,
            name: "my factory"
        )
        XCTAssertEqual(key3, key4)
        XCTAssertEqual(key3.hashValue, key4.hashValue)
    }

    func testServiceKeyDoesNotEqualWithDifferentNames() {
        let key1 = ServiceKey(serviceType: Animal.self, argumentsType: Resolver.self, name: "my factory")
        let key2 = ServiceKey(serviceType: Animal.self, argumentsType: Resolver.self, name: "your factory")
        XCTAssertNotEqual(key1, key2)
        XCTAssertNotEqual(key1.hashValue, key2.hashValue)

        let key3 = ServiceKey(
            serviceType: Animal.self,
            argumentsType: (Resolver, String, Bool).self,
            name: "my factory"
        )
        let key4 = ServiceKey(
            serviceType: Animal.self,
            argumentsType: (Resolver, String, Bool).self,
            name: "your factory"
        )
        XCTAssertNotEqual(key3, key4)
        XCTAssertNotEqual(key3.hashValue, key4.hashValue)
    }

    // MARK: With option

    func testServiceKeyEqualsWithTheSameOption() {
        let key1 = ServiceKey(serviceType: Animal.self, argumentsType: Resolver.self, option: Option(option: 1))
        let key2 = ServiceKey(serviceType: Animal.self, argumentsType: Resolver.self, option: Option(option: 1))
        XCTAssertEqual(key1, key2)
        XCTAssertEqual(key1.hashValue, key2.hashValue)

        let key3 = ServiceKey(
            serviceType: Animal.self,
            argumentsType: (Resolver, String, Bool).self,
            option: Option(option: 1)
        )
        let key4 = ServiceKey(
            serviceType: Animal.self,
            argumentsType: (Resolver, String, Bool).self,
            option: Option(option: 1)
        )
        XCTAssertEqual(key3, key4)
        XCTAssertEqual(key3.hashValue, key4.hashValue)
    }

    func testServiceKeyDoesNotEqualWithDifferentOptions() {
        let key1 = ServiceKey(serviceType: Animal.self, argumentsType: Resolver.self, option: Option(option: 1))
        let key2 = ServiceKey(serviceType: Animal.self, argumentsType: Resolver.self, option: Option(option: 2))
        XCTAssertNotEqual(key1, key2)
        XCTAssertNotEqual(key1.hashValue, key2.hashValue)

        let key3 = ServiceKey(
            serviceType: Animal.self,
            argumentsType: (Resolver, String, Bool).self,
            option: Option(option: 1)
        )
        let key4 = ServiceKey(
            serviceType: Animal.self,
            argumentsType: (Resolver, String, Bool).self,
            option: Option(option: 2)
        )
        XCTAssertNotEqual(key3, key4)
        XCTAssertNotEqual(key3.hashValue, key4.hashValue)
    }
}
