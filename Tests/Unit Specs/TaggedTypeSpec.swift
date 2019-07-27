//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class TaggedTypeSpec: QuickSpec { override func spec() {
    describe("hashValue") {
        it("is different for different types") {
            let first = plain(Int.self)
            let second = plain(String.self)
            expect(first.hashValue) != second.hashValue
        }
        it("is different for different tags") {
            let first = tagged(Int.self, with: "tag1")
            let second = tagged(Int.self, with: "tag2")
            expect(first.hashValue) != second.hashValue
        }
        it("is same for the same descriptor") {
            let first = tagged(Int.self, with: "tag1")
            let second = tagged(Int.self, with: "tag1")
            expect(first.hashValue) == second.hashValue
        }
        it("is same for the type and it's optional") {
            let first = plain(Int.self)
            let second = plain(Int?.self)
            expect(first.hashValue) == second.hashValue
        }
        it("is same for the type and it's double optional") {
            let first = plain(Int.self)
            let second = plain(Int??.self)
            expect(first.hashValue) == second.hashValue
        }
    }
} }
