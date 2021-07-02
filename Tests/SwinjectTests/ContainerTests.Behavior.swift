//
//  Copyright © 2021 Swinject Contributors. All rights reserved.
//

import XCTest
@testable import Swinject

class ContainerTests_Behavior: XCTestCase {
    var container: Container!

    override func setUpWithError() throws {
        container = Container()
    }

    // MARK: Adding service

    func testBehaviorShouldBeInvokedWhenAddingService() {
        let spy1 = BehaviorSpy()
        let spy2 = BehaviorSpy()
        container.addBehavior(spy1)
        container.addBehavior(spy2)

        container.register(Dog.self) { _ in Dog() }

        XCTAssertEqual(spy1.entries.count, 1)
        XCTAssertEqual(spy2.entries.count, 1)
    }

    func testBehaviorShoulBeInvokedUsingProperNameWhenAddingService() {
        let spy = BehaviorSpy()
        container.addBehavior(spy)

        container.register(Dog.self, name: "Hachi") { _ in Dog() }
        container.register(Cat.self) { _ in Cat() }

        XCTAssertEqual(spy.names[0], "Hachi")
        XCTAssertNil(spy.names[1])
    }

    func testBehaviorShouldBeInvokedUsingProperTypeWhenAddingService() {
        let spy = BehaviorSpy()
        container.addBehavior(spy)

        container.register(Animal.self) { _ in Dog() }

        XCTAssert(spy.types.first == Animal.self)
    }

    // MARK: Forwarding service

    func testBehaviorShouldBeInvokedWhenForwardingService() {
        let spy1 = BehaviorSpy()
        let spy2 = BehaviorSpy()
        container.addBehavior(spy1)
        container.addBehavior(spy2)

        container.register(Dog.self) { _ in Dog() }
            .implements(Animal.self)

        XCTAssertEqual(spy1.entries.count, 2)
        XCTAssertEqual(spy2.entries.count, 2)
    }

    func testBehaviorShoulBeInvokedUsingProperNameWhenForwardingService() {
        let spy = BehaviorSpy()
        container.addBehavior(spy)

        container.register(Dog.self, name: "Hachi") { _ in Dog() }
            .implements(Animal.self)

        XCTAssertEqual(spy.names[0], "Hachi")
        XCTAssertNil(spy.names[1])
    }

    func testBehaviorShouldBeInvokedUsingProperTypeWhenForwardingService() {
        let spy = BehaviorSpy()
        container.addBehavior(spy)

        container.register(Dog.self, name: "Hachi") { _ in Dog() }
            .implements(Animal.self)

        XCTAssert(spy.types[0] == Dog.self)
        XCTAssert(spy.types[1] == Animal.self)
    }

    // MARK: Convenience initialiser

    func testConvenienceInitializerAddsBehaviorsToContainer() {
        let spy1 = BehaviorSpy()
        let spy2 = BehaviorSpy()
        container = Container(behaviors: [spy1, spy2])

        container.register(Dog.self) { _ in Dog() }

        XCTAssertEqual(spy1.entries.count, 1)
        XCTAssertEqual(spy2.entries.count, 1)
    }
}
