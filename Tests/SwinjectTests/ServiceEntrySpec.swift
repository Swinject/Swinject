//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class ServiceEntrySpec: QuickSpec {
    override func spec() {
        it("has ObjectScope.graph as a default value of scope property.") {
            let entry = ServiceEntry(serviceType: Int.self, argumentsType: Any.self, factory: { 0 })
            expect(entry.objectScope) === ObjectScope.graph
        }

        it("has ObjectScope set to value from init.") {
            let entry = ServiceEntry(
                serviceType: Int.self,
                argumentsType: Any.self,
                factory: { 0 },
                objectScope: .weak
            )
            expect(entry.objectScope) === ObjectScope.weak
        }
    }
}
