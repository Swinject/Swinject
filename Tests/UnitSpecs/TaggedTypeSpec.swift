//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class TaggedTypeSpec: QuickSpec { override func spec() {
    describe("hashValue") {
        it("is different for different types") {
            expect(plain(Int.self).hashValue) != plain(String.self).hashValue
        }
        it("is different for different tags") {
            expect(tagged(Int.self, with: "tag1").hashValue) != tagged(Int.self, with: "tag2").hashValue
        }
        it("is same for the same descriptor") {
            expect(tagged(Int.self, with: "tag1").hashValue) == tagged(Int.self, with: "tag1").hashValue
        }
    }
} }
