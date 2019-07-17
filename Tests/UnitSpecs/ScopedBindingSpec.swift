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
        var lock = ReplayLock()
        var registry = ScopeRegistryMock()
        var scope = AnyScopeMock()
        var maker = AnyInstanceMakerMock()
        var binding: ScopedBinding!
        beforeEach {
            lock = ReplayLock()
            registry = ScopeRegistryMock()
            scope = AnyScopeMock()
            scope.lock = lock
            scope.registryForReturnValue = registry
            maker = AnyInstanceMakerMock()
            key = AnyBindingKeyMock()
            key.descriptor = AnyTypeDescriptorMock()
            binding = ScopedBinding(key: key, maker: maker, scope: scope)
        }
        it("syncs using scope's lock") {
            _ = try? binding.instance(arg: (), context: (), resolver: DummyResolver())
            expect(lock.syncCallsCount) == 1
        }
        context("no instance in registry") {
            beforeEach {
                registry.instanceForReturnValue = nil
            }
            it("returns instance produced by maker") {
                maker.makeInstanceArgContextResolverReturnValue = 42
                let instance = try? binding.instance(arg: (), context: (), resolver: DummyResolver()) as? Int
                expect(instance) == 42
            }
            it("rethrows error from maker") {
                maker.makeInstanceArgContextResolverThrowableError = TestError()
                expect {
                    try binding.instance(arg: (), context: (), resolver: DummyResolver())
                }.to(throwError(errorType: TestError.self))
            }
            it("puts made instance into registry") {
                maker.makeInstanceArgContextResolverReturnValue = 42
                _ = try? binding.instance(arg: (), context: (), resolver: DummyResolver())
                expect(registry.registerForReceivedArguments?.instance as? Int) == 42
            }
            it("invokes maker with correct parameters") {
                let resolver = DummyResolver()
                _ = try? binding.instance(arg: 42, context: "context", resolver: resolver)
                expect(maker.makeInstanceArgContextResolverReceivedArguments?.arg as? Int) == 42
                expect(maker.makeInstanceArgContextResolverReceivedArguments?.context as? String) == "context"
                expect(maker.makeInstanceArgContextResolverReceivedArguments?.resolver) === resolver
            }
            it("puts instance into registry using a correct key") {
                let descriptor = AnyTypeDescriptorMock()
                key.descriptor = descriptor
                _ = try? binding.instance(arg: 42, context: (), resolver: DummyResolver())
                expect(registry.registerForReceivedArguments?.key.argument as? Int) == 42
                expect(registry.registerForReceivedArguments?.key.descriptor) === descriptor
            }
        }
        context("instance in registry") {
            beforeEach {
                registry.instanceForReturnValue = 42
            }
            it("returns instance from registry") {
                let instance = try? binding.instance(arg: (), context: (), resolver: DummyResolver()) as? Int
                expect(instance) == 42
            }
        }
        it("retrieves registry using passed context") {
            _ = try? binding.instance(arg: (), context: "context", resolver: DummyResolver())
            expect(scope.registryForReceivedContext as? String) == "context"
        }
        it("retrieves instance from registry using a correct key") {
            let descriptor = AnyTypeDescriptorMock()
            key.descriptor = descriptor
            _ = try? binding.instance(arg: 42, context: (), resolver: DummyResolver())
            expect(registry.instanceForReceivedKey?.argument as? Int) == 42
            expect(registry.instanceForReceivedKey?.descriptor) === descriptor
        }
    }
} }
