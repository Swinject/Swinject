//
//  Copyright © 2021 Swinject Contributors. All rights reserved.
//

import XCTest
@testable import Swinject

class ContainerTests_DebugHelper: XCTestCase {
    private var spy: DebugHelperSpy!

    override func setUpWithError() throws {
        spy = DebugHelperSpy()
    }

    // MARK: Resolution fails

    func testContainerShouldCallDebugHelperWithFailingServiceAndKey() {
        let container = Container(debugHelper: spy, resolverHierarchyAccess: .receiver)

        _ = container._resolve(name: "name") { (_, _: (Int) -> Any) in 1 as Double } as Double?

        XCTAssertEqual("\(spy.serviceType)", "Double")
        XCTAssertEqual(spy.key, ServiceKey(
            serviceType: Double.self,
            argumentsType: Int.self,
            name: "name",
            option: nil
        ))
    }

    func testContainerShouldCallHelperWithAllRegistrations() {
        let container = Container(debugHelper: spy, resolverHierarchyAccess: .receiver)
        container.register(Int.self) { _ in 0 }
        container.register(Double.self) { _ in 0 }

        _ = container.resolve(String.self)

        XCTAssertEqual(spy.availableRegistrations?.count, 2)
    }

    func testContainerShouldCallHelperWithParentRegistrations() {
        let parent = Container()
        parent.register(Int.self) { _ in 0 }
        let container = Container(parent: parent, debugHelper: spy, resolverHierarchyAccess: .receiver)
        container.register(Double.self) { _ in 0 }

        _ = container.resolve(String.self)

        XCTAssertEqual(spy.availableRegistrations?.count, 2)
    }
}

private class DebugHelperSpy: DebugHelper {
    var serviceType: Any = ""
    var key: ServiceKey?
    var availableRegistrations: [ServiceKey: ServiceEntryProtocol]?

    func resolutionFailed<Service>(
        serviceType: Service.Type,
        key: ServiceKey,
        availableRegistrations: [ServiceKey: ServiceEntryProtocol]
    ) {
        self.serviceType = serviceType
        self.key = key
        self.availableRegistrations = availableRegistrations
    }
}
