//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class SwinjectSpec: QuickSpec { override func spec() {
    var swinject: Swinject!
    var binding = BindingMock()
    beforeEach {
        binding = BindingMock()
        binding.instanceArgContextResolverReturnValue = 0
        swinject = Swinject(binding)
    }
    describe("instance injection") {
        context("single binding") {
            it("does not request instance from matching binding until instance is required") {
                binding.matchesReturnValue = true
                expect(binding.instanceArgContextResolverCallsCount) == 0
            }
            it("only requests instance from matching binding") {
                binding.matchesReturnValue = false
                _ = try? swinject.instance(of: Any.self)
                expect(binding.instanceArgContextResolverCallsCount) == 0
            }
            it("matches binding with correct context") {
                binding.matchesReturnValue = false
                _ = try? swinject.on("context").instance() as Int
                expect(binding.matchesReceivedKey?.contextType is String.Type).to(beTrue())
            }
        }
    }
    describe("provider injection") {
        it("does not request provided type until provider is called") {
            binding.matchesReturnValue = true
            binding.instanceArgContextResolverReturnValue = 42
            _ = swinject.provider(of: Int.self)
            expect(binding.instanceArgContextResolverCallsCount) == 0
        }
        it("matches binding with correct context") {
            binding.matchesReturnValue = false
            _ = try? swinject.on("context").provider()() as Int
            expect(binding.matchesReceivedKey?.contextType is String.Type).to(beTrue())
        }
        it("passes given context to the binding") {
            binding.matchesReturnValue = true
            _ = try? swinject.on("context").provider()() as Int
            expect(binding.instanceReceivedArguments?.context as? String) == "context"
        }
        it("passes given context to dependency binding") {
            let binding = BindingMock()
            binding.matchesClosure = { $0.descriptor.matches(plain(Double.self)) }
            binding.instanceArgContextResolverReturnValue = 0.0
            let swinject = Swinject(
                bbind(Int.self) & provider { Int(try $0.instance() as Double) },
                binding
            )
            _ = try? swinject.on("context").instance(of: Int.self)
            expect(binding.instanceReceivedArguments?.context as? String) == "context"
        }
    }
    describe("factory injection") {
        it("does not request created type until factory is called") {
            binding.matchesReturnValue = true
            binding.instanceArgContextResolverReturnValue = 42
            _ = swinject.factory() as (String) throws -> Int
            expect(binding.instanceArgContextResolverCallsCount) == 0
        }
        it("matches binding with correct context") {
            binding.matchesReturnValue = false
            _ = try? swinject.on("context").factory()("arg") as Int
            expect(binding.matchesReceivedKey?.contextType is String.Type).to(beTrue())
        }
        it("passes given context to the bidndning") {
            binding.matchesReturnValue = true
            _ = try? swinject.on("context").factory()("arg") as Int
            expect(binding.instanceReceivedArguments?.context as? String) == "context"
        }
    }
    describe("context translators") {
        var translators = [AnyContextTranslatorMock]()
        var bindings = [BindingMock]()
        beforeEach {
            translators = (1 ... 3).map { _ in AnyContextTranslatorMock() }
            translators.forEach {
                $0.sourceType = Void.self
                $0.targetType = Void.self
                $0.translateReturnValue = 0
            }
            bindings = Array(0 ..< 3).map { _ in BindingMock() }
            bindings.forEach {
                $0.matchesReturnValue = false
                $0.instanceArgContextResolverReturnValue = 0
            }
            swinject = Swinject(
                bindings[0], bindings[1], bindings[2],
                translators[0], translators[1], translators[2]
            )
        }
        it("does not throw if one of context translators has correct context translation") {
            bindings[0].matchesClosure = { $0.contextType == Int.self }
            translators[1].sourceType = String.self
            translators[1].targetType = Int.self
            expect { try swinject.on("context").instance() as Int }.notTo(throwError())
        }
        it("throws if translator has incorrect source type") {
            bindings[0].matchesClosure = { $0.contextType == Int.self }
            translators[1].sourceType = Double.self
            translators[1].targetType = Int.self
            expect { try swinject.on("context").instance() as Int }.to(throwError())
        }
        it("throws if multiple translators have correct translation") {
            bindings[0].matchesClosure = { $0.contextType == Int.self }
            bindings[1].matchesClosure = { $0.contextType == Float.self }
            translators[0].sourceType = String.self
            translators[0].targetType = Int.self
            translators[1].sourceType = String.self
            translators[1].targetType = Float.self
            expect { try swinject.on("context").instance() as Int }.to(throwError())
        }
        it("does not throw if multiple translators have correct target type but not source type") {
            bindings[0].matchesClosure = { $0.contextType == Int.self }
            bindings[1].matchesClosure = { $0.contextType == Float.self }
            translators[0].sourceType = String.self
            translators[0].targetType = Int.self
            translators[1].sourceType = Double.self
            translators[1].targetType = Float.self
            expect { try swinject.on("context").instance() }.notTo(throwError())
        }
        it("throws if has binding for given context and translator with correct context translation") {
            bindings[0].matchesClosure = { $0.contextType == Int.self }
            bindings[1].matchesClosure = { $0.contextType == String.self }
            translators[0].sourceType = String.self
            translators[0].targetType = Int.self
            expect { try swinject.on("context").instance() as Int }.to(throwError())
        }
        it("passes translated context to binding") {
            bindings[0].matchesClosure = { $0.contextType == Int.self }
            translators[0].sourceType = String.self
            translators[0].targetType = Int.self
            translators[0].translateReturnValue = 42
            _ = try? swinject.on("context").instance() as Int
            expect(bindings[0].instanceReceivedArguments?.context as? Int) == 42
        }
        it("passes original context to context resolver") {
            bindings[0].matchesClosure = { $0.contextType == Int.self }
            translators[0].sourceType = String.self
            translators[0].targetType = Int.self
            _ = try? swinject.on("context").instance() as Int
            expect(translators[0].translateReceivedContext as? String) == "context"
        }
        it("does not throw if single binding can be used with multiple translated contexts") {
            bindings[0].matchesReturnValue = true
            translators[1 ... 2].forEach {
                $0.sourceType = String.self
                $0.targetType = Int.self
                $0.translateReturnValue = 0
            }
            expect { try swinject.on("context").instance() }.notTo(throwError())
        }
    }
} }
