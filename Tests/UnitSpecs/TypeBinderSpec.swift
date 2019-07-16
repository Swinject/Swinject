//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class TypeBinderSpec: QuickSpec { override func spec() {
    var descriptor = AnyTypeDescriptorMock()
    var binding = AnyBindingMock()
    beforeEach {
        descriptor = AnyTypeDescriptorMock()
        binding = AnyBindingMock()
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
            let entry = bbind(descriptor).with(binding)
            expect(entry.key.descriptor) === descriptor
        }
        it("produces entry with correct argument type") {
            let entry = bbind(Any.self).with(DummyBinding<Int>())
            expect(entry.key.argumentType is Int.Type).to(beTrue())
        }
        it("produces entry with correct binding") {
            let entry = bbind(Any.self).with(binding)
            expect(entry.binding) === binding
        }
        it("produces entry if given value of descriptor type") {
            let entry = bbind(Int.self).with(42)
            expect(entry.binding is SimpleBinding<Int, Void>).to(beTrue())
        }
    }
    describe("& operator") {
        it("produces entry with correct descriptor") {
            let entry = bbind(descriptor) & binding
            expect(entry.key.descriptor) === descriptor
        }
        it("produces entry with correct argument type") {
            let entry = bbind(Any.self) & DummyBinding<Int>()
            expect(entry.key.argumentType is Int.Type).to(beTrue())
        }
        it("produces entry with correct binding") {
            let entry = bbind(Any.self) & binding
            expect(entry.binding) === binding
        }
        it("produces entry provider if given value of descriptor type") {
            let entry = bbind(Int.self) & 42
            expect(entry.binding is SimpleBinding<Int, Void>).to(beTrue())
        }
    }
} }
