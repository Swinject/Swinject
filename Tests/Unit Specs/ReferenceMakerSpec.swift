//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class ReferenceMakerSpec: QuickSpec { override func spec() {
    var maker: ReferenceMaker!
    describe("strongRef") {
        beforeEach {
            maker = strongRef
        }
        it("returns given value") {
            let human = Human()
            let reference = maker.makeReference(for: human)
            expect(reference.value) === human
        }
        it("persists given value") {
            let reference = maker.makeReference(for: Human())
            expect(reference.value).notTo(beNil())
        }
    }
    describe("weakRef") {
        beforeEach {
            maker = weakRef
        }
        it("returns given value") {
            let human = Human()
            let reference = maker.makeReference(for: human)
            expect(reference.value) === human
        }
        it("does not keep strong reference on value") {
            let reference = maker.makeReference(for: Human())
            expect(reference.value).to(beNil())
        }
    }
} }
