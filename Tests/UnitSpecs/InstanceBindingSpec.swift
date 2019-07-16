//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class InstanceBindingSpec: QuickSpec { override func spec() {
    it("returns given instance") {
        let binding = instance(42)
        expect { try binding.instance(resolver: DummyResolver()) } == 42
    }
} }
