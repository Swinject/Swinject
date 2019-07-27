//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class BindingKeySpec: QuickSpec { override func spec() {
    describe("matching") {
        var key: BindingKey!
        var descriptor = AnyTypeDescriptorMock()
        var otherKey = AnyBindingKeyMock()
        beforeEach {
            descriptor = AnyTypeDescriptorMock()
            descriptor.matchesReturnValue = true
            key = makeKey(descriptor: descriptor)
            otherKey = AnyBindingKeyMock()
            otherKey.descriptor = AnyTypeDescriptorMock()
            otherKey.argumentType = Void.self
            otherKey.contextType = Void.self
        }
        it("does not match if descriptors don't match") {
            descriptor.matchesReturnValue = false
            expect { key.matches(otherKey) }.to(beFalse())
        }
        it("it checks if descriptors match") {
            let otherDescriptor = AnyTypeDescriptorMock()
            _ = key.matches(makeKey(descriptor: otherDescriptor))
            expect(descriptor.matchesReceivedOther) === otherDescriptor
        }
        it("matches if descriptors match") {
            descriptor.matchesReturnValue = true
            expect { key.matches(otherKey) }.to(beTrue())
        }
        it("does not match if argument types are different") {
            let key = makeKey(descriptor: descriptor, argumentType: Int.self)
            otherKey.argumentType = Double.self
            expect(key.matches(otherKey)).to(beFalse())
        }
        it("matches if argument types are the same") {
            let key = makeKey(descriptor: descriptor, argumentType: Int.self)
            otherKey.argumentType = Int.self
            expect(key.matches(otherKey)).to(beTrue())
        }
        it("does not match if context types are different") {
            let key = makeKey(descriptor: descriptor, contextType: Int.self)
            otherKey.contextType = Double.self
            expect(key.matches(otherKey)).to(beFalse())
        }
        it("matches if argument context are the same") {
            let key = makeKey(descriptor: descriptor, contextType: Int.self)
            otherKey.contextType = Int.self
            expect(key.matches(otherKey)).to(beTrue())
        }
        it("matches if context is Any") {
            let key = makeKey(descriptor: descriptor, contextType: Any.self)
            otherKey.contextType = Int.self
            expect(key.matches(otherKey)).to(beTrue())
        }
    }
} }

private func makeKey(
    descriptor: AnyTypeDescriptor,
    contextType: Any.Type = Void.self,
    argumentType: Any.Type = Void.self
) -> BindingKey {
    return BindingKey(descriptor: descriptor, contextType: contextType, argumentType: argumentType)
}
