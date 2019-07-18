//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class StandardScopeRegistrySpec: QuickSpec { override func spec() {
    var registry: StandardScopeRegistry!
    beforeEach {
        registry = StandardScopeRegistry()
    }
    describe("empty") {
        it("returns no instance") {
            expect(registry.instance(for: dummyKey)).to(beNil())
        }
    }
} }

let dummyKey = ScopeRegistryKey(descriptor: plain(Void.self), argument: 0)
