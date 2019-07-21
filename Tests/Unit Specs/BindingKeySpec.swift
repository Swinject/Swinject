//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class BindingKeySpec: QuickSpec { override func spec() {
    typealias AnyBindingKey = BindingKey<AnyTypeDescriptorMock, Void, Void>
    typealias ArgumentBindingKey<Arg> = BindingKey<AnyTypeDescriptorMock, Void, Arg>
    typealias ContextBindingKey<Ctx> = BindingKey<AnyTypeDescriptorMock, Ctx, Void>

    describe("matching") {
        var key: AnyBindingKey!
        var descriptor = AnyTypeDescriptorMock()
        var otherKey = AnyBindingKeyMock()
        beforeEach {
            descriptor = AnyTypeDescriptorMock()
            descriptor.matchesReturnValue = true
            key = AnyBindingKey(descriptor: descriptor)
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
            _ = key.matches(AnyBindingKey(descriptor: otherDescriptor))
            expect(descriptor.matchesReceivedOther) === otherDescriptor
        }
        it("matches if descriptors match") {
            descriptor.matchesReturnValue = true
            expect { key.matches(otherKey) }.to(beTrue())
        }
        it("does not match if argument types are different") {
            let key = ArgumentBindingKey<Int>(descriptor: descriptor)
            otherKey.argumentType = Double.self
            expect(key.matches(otherKey)).to(beFalse())
        }
        it("matches if argument types are the same") {
            let key = ArgumentBindingKey<Int>(descriptor: descriptor)
            otherKey.argumentType = Int.self
            expect(key.matches(otherKey)).to(beTrue())
        }
        it("does not match if context types are different") {
            let key = ContextBindingKey<Int>(descriptor: descriptor)
            otherKey.contextType = Double.self
            expect(key.matches(otherKey)).to(beFalse())
        }
        it("matches if argument context are the same") {
            let key = ContextBindingKey<Int>(descriptor: descriptor)
            otherKey.contextType = Int.self
            expect(key.matches(otherKey)).to(beTrue())
        }
        it("matches if context is Any") {
            let key = ContextBindingKey<Any>(descriptor: descriptor)
            otherKey.contextType = Int.self
            expect(key.matches(otherKey)).to(beTrue())
        }
    }
} }
