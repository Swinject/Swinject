//
//  Copyright © 2021 Swinject Contributors. All rights reserved.
//

import XCTest
@testable import Swinject

class ContainerTests_CustomScope: XCTestCase {
    var container: Container!

    override func setUpWithError() throws {
        container = Container()
    }

    // MARK: Resolving from custom scope

    func testContainerCreatesNewInstanceStorageForEachService() {
        var instances = 0
        let custom = ObjectScope(storageFactory: { instances += 1; return FakeStorage() })

        container.register(Int.self) { _ in 0 }.inObjectScope(custom)
        container.register(Double.self) { _ in 0 }.inObjectScope(custom)
        _ = container.resolve(Int.self)
        _ = container.resolve(Double.self)

        XCTAssertEqual(instances, 2)
    }

    func testContainerStoresInstanceToStorageDuringResolution() {
        let storage = FakeStorage()
        let custom = ObjectScope(storageFactory: { storage })

        container.register(Int.self) { _ in 42 }.inObjectScope(custom)
        _ = container.resolve(Int.self)

        XCTAssertEqual(storage.instance as? Int, 42)
    }

    func testContainerReturnsStoredInstanceIfStorageIsNotEmpty() {
        let storage = FakeStorage()
        let custom = ObjectScope(storageFactory: { storage })

        container.register(Int.self) { _ in 0 }.inObjectScope(custom)
        storage.instance = 42
        let result = container.resolve(Int.self)

        XCTAssertEqual(result, 42)
    }

    // MARK: Resetting scope

    func testContainerRemovesInstanceFromServicesInGivenScope() {
        let storage = FakeStorage()
        let custom = ObjectScope(storageFactory: { storage })

        container.register(Int.self) { _ in 0 }.inObjectScope(custom)
        storage.instance = 42
        container.resetObjectScope(custom)

        XCTAssertNil(storage.instance)
    }

    func testContainerDoesNotRemoveInstancesFromOtherScopes() {
        let storage = FakeStorage()
        let custom1 = ObjectScope(storageFactory: { storage })
        let custom2 = ObjectScope(storageFactory: FakeStorage.init)

        container.register(Int.self) { _ in 0 }.inObjectScope(custom1)
        storage.instance = 42
        container.resetObjectScope(custom2)

        XCTAssertEqual(storage.instance as? Int, 42)
    }

    func testContainerRemovesInstanceFromServiceRegisteredInParentContainer() {
        let storage = FakeStorage()
        let custom = ObjectScope(storageFactory: { storage })
        let child = Container(parent: container)

        container.register(Int.self) { _ in 0 }.inObjectScope(custom)
        storage.instance = 42
        child.resetObjectScope(custom)

        XCTAssertNil(storage.instance)
    }
}

private class FakeStorage: InstanceStorage {
    var instance: Any?
}
