//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class TypeBinderSpec: QuickSpec { override func spec() {
    var descriptor = AnyTypeDescriptorMock()
    var maker = AnyBindningMakerMock()
    beforeEach {
        descriptor = AnyTypeDescriptorMock()
        maker = AnyBindningMakerMock()
        maker.makeBindingForReturnValue = BindingMock()
    }
    describe("bind") {
        it("descriptor has correct tag for tagged type") {
            let descriptor = bbind(Int.self, tagged: "Foo").descriptor
            expect(descriptor.tag) == "Foo"
        }
        it("descriptor is used if given as parameter") {
            let request = bbind(descriptor: descriptor)
            expect(request.descriptor) === descriptor
        }
    }
    describe("`with` method") {
        it("passes descriptor to maker") {
            _ = bbind(descriptor: descriptor).with(maker)
            expect(maker.makeBindingForReceivedDescriptor) === descriptor
        }
        it("returns binding from maker") {
            let binding = BindingMock()
            maker.makeBindingForReturnValue = binding
            expect(bbind(descriptor: descriptor).with(maker)) === binding
        }
        it("works with passing instance directly") {
            let binding = bbind(descriptor: descriptor).with(42)
            expect { try binding.instance(arg: (), context: (), resolver: DummyResolver()) as? Int } == 42
        }
    }
    describe("`&` method") {
        it("passes descriptor to maker") {
            _ = bbind(descriptor: descriptor) & maker
            expect(maker.makeBindingForReceivedDescriptor) === descriptor
        }
        it("returns binding from maker") {
            let binding = BindingMock()
            maker.makeBindingForReturnValue = binding
            expect(bbind(descriptor: descriptor) & maker) === binding
        }
        it("works with passing instance directly") {
            let binding = bbind(descriptor: descriptor) & 42
            expect { try binding.instance(arg: (), context: (), resolver: DummyResolver()) as? Int } == 42
        }
    }
} }
