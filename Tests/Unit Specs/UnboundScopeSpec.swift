//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class UnboundScopeSpec: QuickSpec { override func spec() {
    var registry = StaticScopeRegistryMock()
    var scope: UnboundScope!
    beforeEach {
        registry = StaticScopeRegistryMock()
        scope = UnboundScope(registry: registry)
    }
    describe("registry") {
        it("returns passed registry") {
            expect(scope.registry(for: 0)) === registry
        }
        it("uses standard registry by default") {
            expect(UnboundScope().registry(for: 0) is StandardScopeRegistry) == true
        }
    }
    describe("closable") {
        it("clears passed registry when closed") {
            scope.close()
            expect(registry.clearCallsCount) == 1
        }
        it("does not clear registry until closed") {
            expect(registry.clearCallsCount) == 0
        }
    }
} }
