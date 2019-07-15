//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class BindingKeySpec: QuickSpec { override func spec() {
    typealias AnyBindingKey<Arg> = BindingKey<AnyTypeDescriptorMock, Arg>

    describe("matching") {
        var key: AnyBindingKey<Void>!
        var descriptor = AnyTypeDescriptorMock()
        var otherKey = AnyBindingKeyMock()
        beforeEach {
            descriptor = AnyTypeDescriptorMock()
            descriptor.matchesReturnValue = true
            key = AnyBindingKey(descriptor: descriptor)
            otherKey = AnyBindingKeyMock()
            otherKey.descriptor = AnyTypeDescriptorMock()
            otherKey.argumentType = Void.self
        }
        it("does not match if descriptors don't match") {
            descriptor.matchesReturnValue = false
            expect { key.matches(otherKey) }.to(beFalse())
        }
        it("it checks if descriptors match") {
            let otherDescriptor = AnyTypeDescriptorMock()
            _ = key.matches(AnyBindingKey<Void>(descriptor: otherDescriptor))
            expect(descriptor.matchesReceivedOther) === otherDescriptor
        }
        it("matches if descriptors match") {
            descriptor.matchesReturnValue = true
            expect { key.matches(otherKey) }.to(beTrue())
        }
        it("does not match if argument types are different") {
            let key = AnyBindingKey<Int>(descriptor: descriptor)
            otherKey.argumentType = Double.self
            expect(key.matches(otherKey)).to(beFalse())
        }
        it("matches if argument types are the same") {
            let key = AnyBindingKey<Int>(descriptor: descriptor)
            otherKey.argumentType = Int.self
            expect(key.matches(otherKey)).to(beTrue())
        }
    }
} }
