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
            let reference = strongRef(human)
            expect(reference.currentValue) === human
        }
        it("persists given value") {
            var reference: Reference<Human>? = strongRef(Human())
            let nextValue = reference!.nextValue
            reference = nil
            expect(nextValue()).notTo(beNil())
        }
    }
    describe("weakRef") {
        it("returns given value") {
            let human = Human()
            let reference = weakRef(human)
            expect(reference.currentValue) === human
        }
        it("does not keep strong reference on value") {
            var reference: Reference<Human>? = weakRef(Human())
            let nextValue = reference!.nextValue
            reference = nil
            expect(nextValue()).to(beNil())
        }
        it("works with type erasure") {
            let human: Mammal = Human()
            let nextValue = { weakRef(human).nextValue() as Any? }
            expect(nextValue() is Mammal) == true
        }
    }
} }
