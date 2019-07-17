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
        it("produces entry with correct descriptor") {
            let entry = bbind(descriptor).with(maker)
            expect(entry.key.descriptor) === descriptor
        }
        it("produces entry with correct argument type") {
            let entry = bbind(Any.self).with(DummyMaker<Void, Int>())
            expect(entry.key.argumentType is Int.Type).to(beTrue())
        }
        it("produces entry with correct context type") {
            let entry = bbind(Any.self).with(DummyMaker<Int, Void>())
            expect(entry.key.contextType is Int.Type).to(beTrue())
        }
        it("produces entry with correct maker") {
            let entry = bbind(Any.self).with(maker)
            expect(entry.maker) === maker
        }
        it("produces entry if given value of descriptor type") {
            let entry = bbind(Int.self).with(42)
            expect(entry.maker is SimpleInstanceMaker<Int, Any, Void>).to(beTrue())
        }
    }
    describe("& operator") {
        it("produces entry with correct descriptor") {
            let entry = bbind(descriptor) & maker
            expect(entry.key.descriptor) === descriptor
        }
        it("produces entry with correct argument type") {
            let entry = bbind(Any.self) & DummyMaker<Void, Int>()
            expect(entry.key.argumentType is Int.Type).to(beTrue())
        }
        it("produces entry with correct context type") {
            let entry = bbind(Any.self) & DummyMaker<Int, Void>()
            expect(entry.key.contextType is Int.Type).to(beTrue())
        }
        it("produces entry with correct maker") {
            let entry = bbind(Any.self) & maker
            expect(entry.maker) === maker
        }
        it("produces entry provider if given value of descriptor type") {
            let entry = bbind(Int.self) & 42
            expect(entry.maker is SimpleInstanceMaker<Int, Any, Void>).to(beTrue())
        }
    }
} }
