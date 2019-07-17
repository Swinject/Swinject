//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class ScopedBindingSpec: QuickSpec { override func spec() {
    describe("binding builder") {
        let descriptor = AnyTypeDescriptorMock()
        let scope = DummyScope<String>()
        let builder = ScopedBinding.Builder<Void, DummyScope<String>, Int>(scope) { _, _, _ in }
        it("makes binding with self as maker") {
            let binding = builder.makeBinding(for: descriptor) as? ScopedBinding
            expect(binding?.maker is ScopedBinding.Builder<Void, DummyScope<String>, Int>).to(beTrue())
        }
        it("makes binding with correct key") {
            let binding = builder.makeBinding(for: descriptor) as? ScopedBinding
            expect(binding?.key.descriptor) === descriptor
            expect(binding?.key.contextType is String.Type).to(beTrue())
            expect(binding?.key.argumentType is Int.Type).to(beTrue())
        }
        it("makes binding with correct scope") {
            let binding = builder.makeBinding(for: descriptor) as? ScopedBinding
            expect(binding?.scope) === scope
        }
    }
    describe("matching") {
        var key = AnyBindingKeyMock()
        var bindingKey = AnyBindingKeyMock()
        var binding: ScopedBinding!
        beforeEach {
            key = AnyBindingKeyMock()
            bindingKey = AnyBindingKeyMock()
            bindingKey.matchesReturnValue = false
            binding = ScopedBinding(key: bindingKey, maker: AnyInstanceMakerMock(), scope: AnyScopeMock())
        }
        it("passes the input key to the binding key") {
            _ = binding.matches(key)
            expect(bindingKey.matchesReceivedOther) === key
        }
        it("returns true if binding key matches") {
            bindingKey.matchesReturnValue = true
            expect(binding.matches(key)).to(beTrue())
        }
        it("returns false if binding key matches") {
            bindingKey.matchesReturnValue = false
            expect(binding.matches(key)).to(beFalse())
        }
    }
} }
