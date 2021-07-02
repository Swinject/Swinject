//
//  Copyright © 2021 Swinject Contributors. All rights reserved.
//

import XCTest
@testable import Swinject

class ContainerTests_GraphCaching: XCTestCase {
    var container: Container!

    override func setUpWithError() throws {
        container = Container()
    }

    // MARK: Restoration

    func testContaineirHasMethodForRestoringGraph() {
        container.restoreObjectGraph(GraphIdentifier())
    }

    // MARK: Current object graph

    func testIdentifierIsNotNilDuringGraphResolution() {
        var identifier: GraphIdentifier?
        container.register(Dog.self) {
            identifier = ($0 as? Container)?.currentObjectGraph
            return Dog()
        }

        _ = container.resolve(Dog.self)

        XCTAssertNotNil(identifier)
    }

    func testIdentifierIsDifferentForSeparateGraphResolutions() {
        var identifiers = [GraphIdentifier?]()
        container.register(Dog.self) {
            identifiers.append(($0 as? Container)?.currentObjectGraph)
            return Dog()
        }

        _ = container.resolve(Dog.self)
        _ = container.resolve(Dog.self)

        XCTAssertEqual(identifiers.count, 2)
        XCTAssertNotEqual(identifiers[0], identifiers[1])
    }

    func testIdentifierIsSameDuringGraphResolution() {
        var identifiers = [GraphIdentifier?]()
        container.register(Dog.self) {
            identifiers.append(($0 as? Container)?.currentObjectGraph)
            _ = $0.resolve(Cat.self)
            return Dog()
        }
        container.register(Cat.self) {
            identifiers.append(($0 as? Container)?.currentObjectGraph)
            return Cat()
        }

        _ = container.resolve(Dog.self)

        XCTAssertEqual(identifiers.count, 2)
        XCTAssertEqual(identifiers[0], identifiers[1])
    }

    func testContainerIsNilOutsideGraphResolution() {
        container.register(Dog.self) { _ in Dog() }

        XCTAssertNil(container.currentObjectGraph)
        _ = container.resolve(Dog.self)
        XCTAssertNil(container.currentObjectGraph)
    }

    // MARK: Object graph restoration

    func testContainerUsesRestoredIdentifierDuringGraphResolution() {
        let restoredIdentifier = GraphIdentifier()
        var identifier: GraphIdentifier?
        container.register(Dog.self) {
            identifier = ($0 as? Container)?.currentObjectGraph
            return Dog()
        }

        container.restoreObjectGraph(restoredIdentifier)
        _ = container.resolve(Dog.self)

        XCTAssertEqual(identifier, restoredIdentifier)
    }

    // MARK: Instance storage interaction

    func testContainerUsesCurrentGraphIdentifierWhenManipulatingInstances() {
        let spy = StorageSpy()
        let graph = GraphIdentifier()
        let scope = ObjectScope(storageFactory: { spy })
        container.register(Dog.self) { _ in Dog() }.inObjectScope(scope)
        container.restoreObjectGraph(graph)

        _ = container.resolve(Dog.self)

        XCTAssertEqual(spy.setterGraphs.last, graph)
        XCTAssertEqual(spy.getterGraphs.last, graph)
    }

    func testContainerRestoresInstancesFromPreviousGraphsIfAvailable() {
        var graph: GraphIdentifier!
        container.register(Dog.self) {
            graph = ($0 as? Container)?.currentObjectGraph
            return Dog()
        }.inObjectScope(.graph)

        let dog1 = container.resolve(Dog.self)!
        container.restoreObjectGraph(graph)
        let dog2 = container.resolve(Dog.self)!

        XCTAssert(dog1 === dog2)
    }
}

private class StorageSpy: InstanceStorage {
    var setterGraphs = [GraphIdentifier]()
    var getterGraphs = [GraphIdentifier]()

    var instance: Any?
    func setInstance(_: Any?, inGraph graph: GraphIdentifier) {
        setterGraphs.append(graph)
    }

    func instance(inGraph graph: GraphIdentifier) -> Any? {
        getterGraphs.append(graph)
        return nil
    }
}
