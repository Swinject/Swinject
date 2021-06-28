//
//  Copyright © 2021 Swinject Contributors. All rights reserved.
//

import XCTest
@testable import Swinject

class ServiceEntryTests: XCTestCase {
    func testServiceEntryHasObjectScopeGraphAsDefault() {
        let entry = ServiceEntry(serviceType: Int.self, argumentsType: Any.self, factory: { 0 })
        XCTAssert(entry.objectScope === ObjectScope.graph)
    }

    func testServiceEntryHasObjectScopeSetToValueFromInit() {
        let entry = ServiceEntry(
            serviceType: Int.self,
            argumentsType: Any.self,
            factory: { 0 },
            objectScope: .weak
        )
        XCTAssert(entry.objectScope === ObjectScope.weak)
    }
}
