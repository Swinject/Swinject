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

    // MARK: Reseting scope with given Service Type

    func testResetObjectScopeRemovesOnlyMatchingScopeInstances() {
        let scope = ObjectScope.container

        container.register(Foo.self) { _ in Foo() }.inObjectScope(scope)
        let instance = container.resolve(Foo.self)

        container.resetObjectScope(scope, serviceType: Foo.self)
        let instanceAfterReset = container.resolve(Foo.self)

        XCTAssertTrue(instance !== instanceAfterReset)
    }
    func testResetObjectScopeDoesNotRemoveInstancesOfDifferentScopes() {
        let containerScope = ObjectScope.container
        let graphScope = ObjectScope.graph

        container.register(Foo.self, name: "containerScoped") { _ in Foo() }.inObjectScope(containerScope)
        container.register(Foo.self, name: "graphScoped") { _ in Foo() }.inObjectScope(graphScope)

        let containerInstance = container.resolve(Foo.self, name: "containerScoped")
        let graphInstance = container.resolve(Foo.self, name: "graphScoped")

        XCTAssertNotNil(graphInstance)

        container.resetObjectScope(graphScope, serviceType: Foo.self)
        let containerInstanceAfterReset = container.resolve(Foo.self, name: "containerScoped")  // container-scoped

        XCTAssertTrue(containerInstance === containerInstanceAfterReset)
    }
    func testResetObjectScopeDoesNotRemoveInstancesOfDifferentTypes() {
        let scope = ObjectScope.container

        container.register(Foo.self) { _ in Foo() }.inObjectScope(scope)
        container.register(Bar.self) { _ in Bar() }.inObjectScope(scope)

        let fooInstance = container.resolve(Foo.self)
        let barInstance = container.resolve(Bar.self)

        container.resetObjectScope(scope, serviceType: Foo.self)
        let newFooInstance = container.resolve(Foo.self)
        let newBarInstance = container.resolve(Bar.self)

        XCTAssertTrue(fooInstance !== newFooInstance)
        XCTAssertTrue(barInstance === newBarInstance)
    }
    func testResetObjectScopeCallsParentContainer() {
        let parentContainer = Container()
        let childContainer = Container(parent: parentContainer)

        let scope = ObjectScope.container

        parentContainer.register(Foo.self) { _ in Foo() }.inObjectScope(scope)
        childContainer.register(Foo.self) { _ in Foo() }.inObjectScope(scope)

        let parentInstance = parentContainer.resolve(Foo.self)
        let childInstance = childContainer.resolve(Foo.self)

        childContainer.resetObjectScope(scope, serviceType: Foo.self)
        let newParentInstance = parentContainer.resolve(Foo.self)
        let newChildInstance = childContainer.resolve(Foo.self)

        XCTAssertFalse(childInstance === newChildInstance)
        XCTAssertFalse(parentInstance === newParentInstance)
    }
}
private class Foo {}
private class Bar {}
private class FakeStorage: InstanceStorage {
    var instance: Any?
}
