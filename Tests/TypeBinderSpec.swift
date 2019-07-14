//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Quick
import Nimble
@testable import Swinject

class TypeBinderSpec: QuickSpec { override func spec() {
    describe("`bind` method") {
        it("descriptor is correct for simple type") {
            let request = bbind(Int.self)
            let descriptor = request.descriptor as? Tagged<Int, NoTag>
            expect(descriptor).notTo(beNil())
        }
        it("descriptor has correct tag for tagged type") {
            let request = bbind(Int.self, tagged: "Foo")
            let descriptor = request.descriptor as? Tagged<Int, String>
            expect(descriptor?.tag) == "Foo"
        }
        it("descriptor is used if given as parameter") {
            let descriptor = IntDescriptor()
            let request = bbind(descriptor)
            expect(request.descriptor) === descriptor
        }
    }
    describe("`with` method") {
        it("produces binding with correct descriptor") {
            let descriptor = IntDescriptor()
            let entry = bbind(descriptor).with(IntBinding())
            expect(entry.descriptor) === descriptor
        }
        it("produces binding with correct binding") {
            let binding = IntBinding()
            let entry = bbind(Int.self).with(binding)
            expect(entry.binding) === binding
        }
        it("produces type provider if given value of descriptor type") {
            let entry = bbind(Int.self).with(42)
            expect(entry.binding is ProviderBinding<Int>).to(beTrue())
        }
    }
    describe("binding operator") {
        it("produces binding with correct descriptor") {
            let descriptor = IntDescriptor()
            let entry = bbind(descriptor) & IntBinding()
            expect(entry.descriptor) === descriptor
        }
        it("produces binding with correct binding") {
            let binding = IntBinding()
            let entry = bbind(Int.self) & binding
            expect(entry.binding) === binding
        }
        it("produces type provider if given value of descriptor type") {
            let entry = bbind(Int.self) & 42
            expect(entry.binding is ProviderBinding<Int>).to(beTrue())
        }
    }
}}
