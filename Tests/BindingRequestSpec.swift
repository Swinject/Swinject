//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Quick
import Nimble
@testable import Swinject3

class BindingRequestSpec: QuickSpec { override func spec() {
    describe("type descriptor") {
        it("is correct for simple type") {
            let request = Swinject3.bind(Int.self)
            let descriptor = request.typeDescriptor as? Tagged<Int, NoTag>
            expect(descriptor).notTo(beNil())
        }
        it("has correct tag for tagged type") {
            let request = Swinject3.bind(Int.self, tagged: "Foo")
            let descriptor = request.typeDescriptor as? Tagged<Int, String>
            expect(descriptor?.tag) == "Foo"
        }
        it("is used if given as parameter") {
            struct Descriptor: TypeDescriptor { typealias BaseType = Int }
            let request = Swinject3.bind(Descriptor())
            expect(request.typeDescriptor is Descriptor).to(beTrue())
        }
    }
}}


