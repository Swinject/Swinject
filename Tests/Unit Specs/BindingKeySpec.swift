//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class BindingKeySpec: QuickSpec { override func spec() {
    describe("matching") {
        var descriptor = AnyTypeDescriptorMock()
        var otherKey = AnyBindingKeyMock()
        beforeEach {
            descriptor = AnyTypeDescriptorMock()
            descriptor.matchesReturnValue = true
            otherKey = AnyBindingKeyMock()
            otherKey.descriptor = AnyTypeDescriptorMock()
            otherKey.argumentType = Void.self
            otherKey.contextType = Void.self
        }
        it("does not match if context types are different") {
            let key = makeKey(descriptor: descriptor, contextType: Int.self)
            otherKey.contextType = Double.self
            expect(key.matches(otherKey)).to(beFalse())
        }
        it("matches if contexts are the same") {
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
