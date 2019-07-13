//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Quick
import Nimble
@testable import Swinject3

class BindingRequestSpec: QuickSpec { override func spec() {
    describe("`bind` method") {
        it("descriptor is correct for simple type") {
            let request = Swinject3.bind(Int.self)
            let descriptor = request.descriptor as? Tagged<Int, NoTag>
            expect(descriptor).notTo(beNil())
        }
        it("descriptor has correct tag for tagged type") {
            let request = Swinject3.bind(Int.self, tagged: "Foo")
            let descriptor = request.descriptor as? Tagged<Int, String>
            expect(descriptor?.tag) == "Foo"
        }
        it("descriptor is used if given as parameter") {
            let descriptor = IntDescriptor()
            let request = Swinject3.bind(descriptor)
            expect(request.descriptor) === descriptor
        }
    }
    describe("`with` method") {
        it("produces binding with correct descriptor") {
            let descriptor = IntDescriptor()
            let binding = Swinject3.bind(descriptor).with(IntManipulator())
            expect(binding.descriptor) === descriptor
        }
        it("produces binding with correct manipulator") {
            let manipulator = IntManipulator()
            let binding = Swinject3.bind(Int.self).with(manipulator)
            expect(binding.manipulator) === manipulator
        }
    }
    describe("binding operator") {
        it("produces binding with correct descriptor") {
            let descriptor = IntDescriptor()
            let binding = Swinject3.bind(descriptor) & IntManipulator()
            expect(binding.descriptor) === descriptor
        }
        it("produces binding with correct manipulator") {
            let manipulator = IntManipulator()
            let binding = Swinject3.bind(Int.self) & manipulator
            expect(binding.manipulator) === manipulator
        }
    }
}}
