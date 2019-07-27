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
        swinject = Swinject { binding }
    }
    describe("instance injection") {
        context("no bindings") {
            it("throws") {
                let swinject = Swinject {}
                expect { try swinject.instance(of: Int.self) }.to(throwError())
            }
        }
        context("single binding") {
            it("request instance from matching binding") {
                binding.matchesReturnValue = true
                _ = try? swinject.instance(of: Any.self)
                expect(binding.instanceArgContextResolverCallsCount) == 1
            }
            it("does not request instance from matching binding until instance is required") {
                binding.matchesReturnValue = true
                expect(binding.instanceArgContextResolverCallsCount) == 0
            }
            it("only requests instance from matching binding") {
                binding.matchesReturnValue = false
                _ = try? swinject.instance(of: Any.self)
                expect(binding.instanceArgContextResolverCallsCount) == 0
            }
            it("returns instance produced by binding") {
                binding.matchesReturnValue = true
                binding.instanceArgContextResolverReturnValue = 42
                expect { try swinject.instance(of: Any.self) as? Int } == 42
            }
            it("rethrows error from binding") {
                binding.matchesReturnValue = true
                binding.instanceArgContextResolverThrowableError = TestError()
                expect { try swinject.instance(of: Any.self) }.to(throwError(errorType: TestError.self))
            }
            it("crashes if bound type does not match requested type") {
                binding.matchesReturnValue = true
                binding.instanceArgContextResolverReturnValue = ""
                expect { _ = try swinject.instance(of: Double.self) }.to(throwError())
            }
            it("does not crash if bound type conforms to the requested type") {
                binding.matchesReturnValue = true
                binding.instanceArgContextResolverReturnValue = 42
                expect { _ = try swinject.instance(of: CustomStringConvertible?.self) }.notTo(throwError())
            }
            it("passes swinject as resolver") {
                binding.matchesReturnValue = true
                _ = try? swinject.instance(of: Any.self)
                expect(binding.instanceArgContextResolverReceivedArguments?.resolver is Swinject).to(beTrue())
            }
            it("matches binding with correct key") {
                binding.matchesReturnValue = false
                _ = try? swinject.instance(tagged: "tag") as Int
                let descriptor = binding.matchesReceivedKey?.descriptor as? Tagged<Int, String>
                expect(descriptor?.tag) == "tag"
            }
            it("matches binding with correct context") {
                binding.matchesReturnValue = false
                _ = try? swinject.on("context").instance() as Int
                expect(binding.matchesReceivedKey?.contextType is String.Type).to(beTrue())
            }
            it("does not throw if has no binding for optional") {
                binding.matchesReturnValue = false
                expect { try swinject.instance() as Int? }.notTo(throwError())
            }
            it("throws if has throwing binding for optional") {
                binding.matchesReturnValue = true
                binding.instanceArgContextResolverThrowableError = TestError()
                expect { try swinject.instance() as Int? }.to(throwError())
            }
        }
        context("multiple bindings") {
            var bindings = [BindingMock]()
            beforeEach {
                bindings = Array(0 ..< 3).map { _ in BindingMock() }
                bindings.forEach {
                    $0.matchesReturnValue = false
                    $0.instanceArgContextResolverReturnValue = 0
                }
                swinject = Swinject {
                    bindings[0]
                    bindings[1]
                    bindings[2]
                }
            }
            it("throws if multiple bindings match requested type") {
                bindings.forEach { $0.matchesReturnValue = true }
                expect { try swinject.instance(of: Any.self) }.to(throwError())
            }
            it("does not throw if single binding matches requested type") {
                bindings[1].matchesReturnValue = true
                expect { try swinject.instance(of: Any.self) }.notTo(throwError())
            }
            it("returns instance from matching binding") {
                bindings[1].matchesReturnValue = true
                bindings[1].instanceArgContextResolverReturnValue = 42
                expect { try swinject.instance(of: Int.self) } == 42
            }
            it("throws if has multiple bindings for optional") {
                bindings[0].matchesReturnValue = true
                bindings[1].matchesReturnValue = true
                expect { try swinject.instance() as Int? }.to(throwError())
            }
        }
    }
    describe("provider injection") {
        it("does not throw if binding matches provided type") {
            binding.matchesReturnValue = true
            binding.instanceArgContextResolverReturnValue = 42
            let provider = swinject.provider() as () throws -> Int
            expect { try provider() }.notTo(throwError())
        }
        it("throws if missing binding for provided type") {
            binding.matchesReturnValue = false
            let provider = swinject.provider() as () throws -> Int
            expect { try provider() }.to(throwError())
        }
        it("does not request provided type until provider is called") {
            binding.matchesReturnValue = true
            binding.instanceArgContextResolverReturnValue = 42
            _ = swinject.provider(of: Int.self)
            expect(binding.instanceArgContextResolverCallsCount) == 0
        }
        it("returns instance from binding") {
            binding.matchesReturnValue = true
            binding.instanceArgContextResolverReturnValue = 42
            let provider = swinject.provider(of: Int.self)
            expect { try provider() } == 42
        }
        it("rethrows binding error from provider") {
            binding.matchesReturnValue = true
            binding.instanceArgContextResolverThrowableError = TestError()
            let provider = swinject.provider(of: Int.self)
            expect { try provider() }.to(throwError(errorType: TestError.self))
        }
        it("matches binding with correct key") {
            binding.matchesReturnValue = true
            _ = try? swinject.provider(of: Any.self, tagged: "tag")()
            let descriptor = binding.matchesReceivedKey?.descriptor as? Tagged<Any, String>
            expect(descriptor?.tag) == "tag"
        }
        it("matches binding with correct context") {
            binding.matchesReturnValue = false
            _ = try? swinject.on("context").provider()() as Int
            expect(binding.matchesReceivedKey?.contextType is String.Type).to(beTrue())
        }
        it("passes given context to the binding") {
            binding.matchesReturnValue = true
            _ = try? swinject.on("context").provider()() as Int
            expect(binding.instanceArgContextResolverReceivedArguments?.context as? String) == "context"
        }
        it("passes given context to dependency binding") {
            let binding = BindingMock()
            binding.matchesClosure = { $0.descriptor.matches(plain(Double.self)) }
            binding.instanceArgContextResolverReturnValue = 0.0
            let swinject = Swinject {
                bbind(Int.self) & provider { Int(try $0.instance() as Double) }
                binding
            }
            _ = try? swinject.on("context").instance(of: Int.self)
            expect(binding.instanceArgContextResolverReceivedArguments?.context as? String) == "context"
        }
    }
    describe("factory injection") {
        it("throws if missing binding for created type") {
            binding.matchesReturnValue = false
            let factory = swinject.factory() as (String) throws -> Int
            expect { try factory("arg") }.to(throwError())
        }
        it("does not throw if binding matches created type") {
            binding.matchesReturnValue = true
            binding.instanceArgContextResolverReturnValue = 42
            let factory = swinject.factory() as (String) throws -> Int
            expect { try factory("arg") }.notTo(throwError())
        }
        it("does not request created type until factory is called") {
            binding.matchesReturnValue = true
            binding.instanceArgContextResolverReturnValue = 42
            _ = swinject.factory() as (String) throws -> Int
            expect(binding.instanceArgContextResolverCallsCount) == 0
        }
        it("rethrows binding error from factory") {
            binding.matchesReturnValue = true
            binding.instanceArgContextResolverThrowableError = TestError()
            let factory = swinject.factory() as (String) throws -> Int
            expect { try factory("arg") }.to(throwError(errorType: TestError.self))
        }
        it("returns instance from binding") {
            binding.matchesReturnValue = true
            binding.instanceArgContextResolverReturnValue = 42
            let factory = swinject.factory() as (String) throws -> Int
            expect { try factory("arg") } == 42
        }
        it("passes given factory argument to binding") {
            binding.matchesReturnValue = true
            binding.instanceArgContextResolverReturnValue = 42
            _ = try? swinject.factory(of: Int.self)("arg")
            let argument = binding.instanceArgContextResolverReceivedArguments?.arg as? MatchableBox1<String>
            expect(argument?.arg1) == "arg"
        }
        it("matches binding with correct key") {
            binding.matchesReturnValue = false
            _ = try? swinject.factory(tagged: "tag")("arg") as Int
            let descriptor = binding.matchesReceivedKey?.descriptor as? Tagged<Int, String>
            expect(descriptor?.tag) == "tag"
        }
        it("matches binding with correct context") {
            binding.matchesReturnValue = false
            _ = try? swinject.on("context").factory()("arg") as Int
            expect(binding.matchesReceivedKey?.contextType is String.Type).to(beTrue())
        }
        it("passes given context to the bidndning") {
            binding.matchesReturnValue = true
            _ = try? swinject.on("context").factory()("arg") as Int
            expect(binding.instanceArgContextResolverReceivedArguments?.context as? String) == "context"
        }
        context("currying") {
            beforeEach {
                binding.matchesReturnValue = true
                binding.instanceArgContextResolverReturnValue = 42
            }
            it("can curry 2-tuple as 0 / 2 argument") {
                _ = try? swinject.factory()("arg1", "arg2") as Int
                let receivedArg = binding.instanceArgContextResolverReceivedArguments?.arg as? MatchableBox2<String, String>
                expect(receivedArg?.arg1) == "arg1"
                expect(receivedArg?.arg2) == "arg2"
            }
            it("can curry 2-tuple as 1 / 1 argument") {
                _ = try? swinject.factory(arg: "arg1")("arg2") as Int
                let receivedArg = binding.instanceArgContextResolverReceivedArguments?.arg as? MatchableBox2<String, String>
                expect(receivedArg?.arg1) == "arg1"
                expect(receivedArg?.arg2) == "arg2"
            }
            it("can curry 3-tuple as 0 / 3 argument") {
                _ = try? swinject.factory()("arg1", 2, "arg3") as Int
                let receivedArg = binding.instanceArgContextResolverReceivedArguments?.arg as? MatchableBox3<String, Int, String>
                expect(receivedArg?.arg1) == "arg1"
                expect(receivedArg?.arg2) == 2
                expect(receivedArg?.arg3) == "arg3"
            }
            it("can curry 3-tuple as 1 / 2 argument") {
                _ = try? swinject.factory(arg: "arg1")(2, "arg3") as Int
                let receivedArg = binding.instanceArgContextResolverReceivedArguments?.arg as? MatchableBox3<String, Int, String>
                expect(receivedArg?.arg1) == "arg1"
                expect(receivedArg?.arg2) == 2
                expect(receivedArg?.arg3) == "arg3"
            }
            it("can curry 3-tuple as 2 / 1 argument") {
                _ = try? swinject.factory(arg: "arg1", 2)("arg3") as Int
                let receivedArg = binding.instanceArgContextResolverReceivedArguments?.arg as? MatchableBox3<String, Int, String>
                expect(receivedArg?.arg1) == "arg1"
                expect(receivedArg?.arg2) == 2
                expect(receivedArg?.arg3) == "arg3"
            }
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
            swinject = Swinject {
                bindings[0]; bindings[1]; bindings[2]
                translators[0]; translators[1]; translators[2]
            }
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
            expect(bindings[0].instanceArgContextResolverReceivedArguments?.context as? Int) == 42
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
