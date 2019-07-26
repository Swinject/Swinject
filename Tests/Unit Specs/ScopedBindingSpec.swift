//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class ScopedBindingSpec: QuickSpec { override func spec() {
    describe("binding builder") {
        var bag = [Any]()
        let descriptor = AnyTypeDescriptorMock()
        let scope = DummyScope<String>()
        let makeRef: ReferenceMaker<Int> = { _ in noRef(42) }
        let builder = ScopedBinding.Builder<Int, DummyScope<String>, Int>(scope, makeRef) { _, _, _ in 0 }
        beforeEach {
            bag.removeAll()
        }
        it("makes binding with self as maker") {
            let binding = builder.makeBinding(for: descriptor) as? ScopedBinding
            expect(binding?.maker is ScopedBinding.Builder<Int, DummyScope<String>, Int>).to(beTrue())
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
        it("makes binding with correct reference maker") {
            let binding = builder.makeBinding(for: descriptor) as? ScopedBinding
            expect(binding?.makeRef(0).currentValue as? Int) == 42
        }
        it("does not hold on to made reference") {
            var human = Human() as Human?
            weak var weakHuman = human
            let builder = ScopedBinding.Builder<Human, DummyScope<String>, Int>(scope, noRef) { _, _, _ in Human() }
            bag.append(builder.makeRef(human!).nextValue)
            human = nil
            expect(weakHuman).to(beNil())
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
            binding = ScopedBinding(
                key: bindingKey, maker: AnyInstanceMakerMock(), scope: AnyScopeMock(), makeRef: noRef
            )
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
            binding = ScopedBinding(key: key, maker: maker, scope: scope, makeRef: noRef)
        }
        it("retrieves registry using passed context") {
            _ = try? binding.instance(arg: (), context: "context", resolver: DummyResolver())
            expect(scope.registryForReceivedContext as? String) == "context"
        }
        it("retrieves instance from registry using a correct key") {
            let descriptor = AnyTypeDescriptorMock()
            key.descriptor = descriptor
            _ = try? binding.instance(arg: 42, context: (), resolver: DummyResolver())
            expect(registry.instanceKeyReceivedKey?.argument as? Int) == 42
            expect(registry.instanceKeyReceivedKey?.descriptor) === descriptor
        }
        context("instance builder") {
            beforeEach {
                scope.registryForReturnValue = BuilderScopeRegistry()
            }
            it("returns instance produced by reference maker") {
                binding = ScopedBinding(key: key, maker: maker, scope: scope) { _ in
                    Reference(currentValue: 42, nextValue: { 42 })
                }
                let instance = try? binding.instance(arg: (), context: (), resolver: DummyResolver()) as? Int
                expect(instance) == 42
            }
            it("invokes reference maker with the instance from the instance maker") {
                var makeRefInput: Any?
                maker.makeInstanceArgContextResolverReturnValue = 42
                binding = ScopedBinding(key: key, maker: maker, scope: scope) {
                    makeRefInput = $0; return noRef($0)
                }
                _ = try? binding.instance(arg: 0, context: (), resolver: DummyResolver())
                expect(makeRefInput as? Int) == 42
            }
            it("rethrows error from instance maker") {
                maker.makeInstanceArgContextResolverThrowableError = TestError()
                expect {
                    try binding.instance(arg: (), context: (), resolver: DummyResolver())
                }.to(throwError(errorType: TestError.self))
            }
            it("invokes instance maker with correct parameters") {
                let resolver = DummyResolver()
                _ = try? binding.instance(arg: 42, context: "context", resolver: resolver)
                expect(maker.makeInstanceArgContextResolverReceivedArguments?.arg as? Int) == 42
                expect(maker.makeInstanceArgContextResolverReceivedArguments?.context as? String) == "context"
                expect(maker.makeInstanceArgContextResolverReceivedArguments?.resolver) === resolver
            }
        }
    }
} }
