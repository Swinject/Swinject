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
    describe("instance") {
        var key = AnyBindingKeyMock()
        var registry = StaticScopeRegistryMock()
        var scope = AnyScopeMock()
        var maker = AnyInstanceMakerMock()
        var binding: ScopedBinding!
        beforeEach {
            registry = StaticScopeRegistryMock()
            scope = AnyScopeMock()
            scope.registryForReturnValue = registry
            maker = AnyInstanceMakerMock()
            key = AnyBindingKeyMock()
            key.descriptor = AnyTypeDescriptorMock()
            binding = ScopedBinding(key: key, maker: maker, scope: scope)
        }
        it("retrieves registry using passed context") {
            _ = try? binding.instance(arg: (), context: "context", resolver: DummyResolver3())
            expect(scope.registryForReceivedContext as? String) == "context"
        }
        it("retrieves instance from registry using a correct key") {
            let descriptor = AnyTypeDescriptorMock()
            key.descriptor = descriptor
            _ = try? binding.instance(arg: 42, context: (), resolver: DummyResolver3())
            expect(registry.instanceKeyReceivedKey?.argument as? Int) == 42
            expect(registry.instanceKeyReceivedKey?.descriptor) === descriptor
        }
        context("instance builder") {
            beforeEach {
                scope.registryForReturnValue = BuilderScopeRegistry()
            }
            it("returns instance produced by maker") {
                maker.makeInstanceArgContextResolver3ReturnValue = 42
                let instance = try? binding.instance(arg: (), context: (), resolver: DummyResolver3()) as? Int
                expect(instance) == 42
            }
            it("rethrows error from maker") {
                maker.makeInstanceArgContextResolver3ThrowableError = TestError()
                expect {
                    try binding.instance(arg: (), context: (), resolver: DummyResolver3())
                }.to(throwError(errorType: TestError.self))
            }
            it("invokes maker with correct parameters") {
                let resolver = DummyResolver3()
                _ = try? binding.instance(arg: 42, context: "context", resolver: resolver)
                expect(maker.makeInstanceArgContextResolver3ReceivedArguments?.arg as? Int) == 42
                expect(maker.makeInstanceArgContextResolver3ReceivedArguments?.context as? String) == "context"
                expect(maker.makeInstanceArgContextResolver3ReceivedArguments?.resolver) === resolver
            }
        }
    }
} }
