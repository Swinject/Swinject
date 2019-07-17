//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class TypeBinderSpec: QuickSpec { override func spec() {
    var descriptor = AnyTypeDescriptorMock()
    var maker = AnyInstanceMakerMock()
    beforeEach {
        descriptor = AnyTypeDescriptorMock()
        maker = AnyInstanceMakerMock()
    }
    describe("bind") {
        it("descriptor has correct tag for tagged type") {
            let descriptor = bbind(Int.self, tagged: "Foo").descriptor
            expect(descriptor.tag) == "Foo"
        }
        it("descriptor is used if given as parameter") {
            let request = bbind(descriptor)
            expect(request.descriptor) === descriptor
        }
    }
    describe("`with` method") {
        it("produces binding with correct descriptor") {
            let binding = bbind(descriptor).with(maker) as? SimpleBinding
            expect(binding?.key.descriptor) === descriptor
        }
        it("produces binding with correct argument type") {
            let binding = bbind(Any.self).with(DummyMaker<Void, Int>()) as? SimpleBinding
            expect(binding?.key.argumentType is Int.Type).to(beTrue())
        }
        it("produces binding with correct context type") {
            let binding = bbind(Any.self).with(DummyMaker<Int, Void>()) as? SimpleBinding
            expect(binding?.key.contextType is Int.Type).to(beTrue())
        }
        it("produces binding with correct maker") {
            let binding = bbind(Any.self).with(maker) as? SimpleBinding
            expect(binding?.maker) === maker
        }
        it("produces binding if given value of descriptor type") {
            let binding = bbind(Int.self).with(42) as? SimpleBinding
            expect(binding?.maker is SimpleBinding.Builder<Int, Any, Void>).to(beTrue())
        }
    }
    describe("& operator") {
        it("produces binding with correct descriptor") {
            let binding = bbind(descriptor) & maker as? SimpleBinding
            expect(binding?.key.descriptor) === descriptor
        }
        it("produces binding with correct argument type") {
            let binding = bbind(Any.self) & DummyMaker<Void, Int>() as? SimpleBinding
            expect(binding?.key.argumentType is Int.Type).to(beTrue())
        }
        it("produces binding with correct context type") {
            let binding = bbind(Any.self) & DummyMaker<Int, Void>() as? SimpleBinding
            expect(binding?.key.contextType is Int.Type).to(beTrue())
        }
        it("produces binding with correct maker") {
            let binding = bbind(Any.self) & maker as? SimpleBinding
            expect(binding?.maker) === maker
        }
        it("produces binding provider if given value of descriptor type") {
            let binding = bbind(Int.self) & 42 as? SimpleBinding
            expect(binding?.maker is SimpleBinding.Builder<Int, Any, Void>).to(beTrue())
        }
    }
} }
