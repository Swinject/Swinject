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
            expect(reference.currentValue) === human
        }
        it("persists given value") {
            var reference: Reference<Human>? = maker.makeReference(for: Human())
            let nextValue = reference!.nextValue
            reference = nil
            expect(nextValue()).notTo(beNil())
        }
    }
    describe("weakRef") {
        beforeEach {
            maker = weakRef
        }
        it("returns given value") {
            let human = Human()
            let reference = maker.makeReference(for: human)
            expect(reference.currentValue) === human
        }
        it("does not keep strong reference on value") {
            var reference: Reference<Human>? = maker.makeReference(for: Human())
            let nextValue = reference!.nextValue
            reference = nil
            expect(nextValue()).to(beNil())
        }
    }
} }
