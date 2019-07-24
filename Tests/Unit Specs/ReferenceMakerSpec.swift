//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class ReferenceMakerSpec: QuickSpec { override func spec() {
    describe("strongRef") {
        it("returns given value") {
            let human = Human()
            let reference = strongRef.makeReference(for: human)
            expect(reference.value) === human
        }
        it("persists given value") {
            let reference = strongRef.makeReference(for: Human())
            expect(reference.value).notTo(beNil())
        }
    }
} }
