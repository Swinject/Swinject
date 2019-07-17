//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class MakerKeySpec: QuickSpec { override func spec() {
    typealias AnyMakerKey = MakerKey<AnyTypeDescriptorMock, Void, Void>
    typealias ArgumentMakerKey<Arg> = MakerKey<AnyTypeDescriptorMock, Void, Arg>
    typealias ContextMakerKey<Ctx> = MakerKey<AnyTypeDescriptorMock, Ctx, Void>

    describe("matching") {
        var key: AnyMakerKey!
        var descriptor = AnyTypeDescriptorMock()
        var otherKey = AnyMakerKeyMock()
        beforeEach {
            descriptor = AnyTypeDescriptorMock()
            descriptor.matchesReturnValue = true
            key = AnyMakerKey(descriptor: descriptor)
            otherKey = AnyMakerKeyMock()
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
            _ = key.matches(AnyMakerKey(descriptor: otherDescriptor))
            expect(descriptor.matchesReceivedOther) === otherDescriptor
        }
        it("matches if descriptors match") {
            descriptor.matchesReturnValue = true
            expect { key.matches(otherKey) }.to(beTrue())
        }
        it("does not match if argument types are different") {
            let key = ArgumentMakerKey<Int>(descriptor: descriptor)
            otherKey.argumentType = Double.self
            expect(key.matches(otherKey)).to(beFalse())
        }
        it("matches if argument types are the same") {
            let key = ArgumentMakerKey<Int>(descriptor: descriptor)
            otherKey.argumentType = Int.self
            expect(key.matches(otherKey)).to(beTrue())
        }
        it("does not match if context types are different") {
            let key = ContextMakerKey<Int>(descriptor: descriptor)
            otherKey.contextType = Double.self
            expect(key.matches(otherKey)).to(beFalse())
        }
        it("matches if argument context are the same") {
            let key = ContextMakerKey<Int>(descriptor: descriptor)
            otherKey.contextType = Int.self
            expect(key.matches(otherKey)).to(beTrue())
        }
        it("matches if context is Any") {
            let key = ContextMakerKey<Any>(descriptor: descriptor)
            otherKey.contextType = Int.self
            expect(key.matches(otherKey)).to(beTrue())
        }
    }
} }
