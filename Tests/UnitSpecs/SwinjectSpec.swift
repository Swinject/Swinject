//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class SwinjectSpec: QuickSpec { override func spec() {
    describe("instance injection") {
        context("no bindings") {
            it("throws") {
                let swinject = Swinject {}
                expect { try swinject.instance(of: Int.self) }.to(throwError())
            }
        }
        context("single binding") {
            var swinject: Swinject!
            var binding = AnyBindingMock()
            var key = AnyBindingKeyMock()
            beforeEach {
                binding = AnyBindingMock()
                key = AnyBindingKeyMock()
                swinject = Swinject { BindingEntry<Any>(key: key, binding: binding) }
            }
            it("request instance from matching binding") {
                key.matchesReturnValue = true
                _ = try? swinject.instance(of: Any.self)
                expect(binding.instanceArgContextResolverCallsCount) == 1
            }
            it("does not request instance from matching binding until instance is required") {
                key.matchesReturnValue = true
                expect(binding.instanceArgContextResolverCallsCount) == 0
            }
            it("only requests instance from matching binding") {
                key.matchesReturnValue = false
                _ = try? swinject.instance(of: Any.self)
                expect(binding.instanceArgContextResolverCallsCount) == 0
            }
            it("returns instance produced by binding") {
                key.matchesReturnValue = true
                binding.instanceArgContextResolverReturnValue = 42
                expect { try swinject.instance(of: Any.self) as? Int } == 42
            }
            it("rethrows error from binding") {
                key.matchesReturnValue = true
                binding.instanceArgContextResolverThrowableError = TestError()
                expect { try swinject.instance(of: Any.self) }.to(throwError(errorType: TestError.self))
            }
            it("crashes if bound type does not match requested type") {
                key.matchesReturnValue = true
                binding.instanceArgContextResolverReturnValue = ""
                expect { _ = try swinject.instance(of: Double.self) }.to(throwError())
            }
            it("does not crash if bound type conforms to the requested type") {
                key.matchesReturnValue = true
                binding.instanceArgContextResolverReturnValue = 42
                expect { _ = try swinject.instance(of: CustomStringConvertible?.self) }.notTo(throwError())
            }
            it("passes swinject as resolver") {
                key.matchesReturnValue = true
                _ = try? swinject.instance(of: Any.self)
                expect(binding.instanceArgContextResolverReceivedArguments?.resolver is Swinject).to(beTrue())
            }
            it("matches binding with correct key") {
                key.matchesReturnValue = false
                _ = try? swinject.instance(tagged: "tag") as Int
                let otherKey = key.matchesReceivedOther as? BindingKey<Tagged<Int, String>, Void, Void>
                let descriptor = otherKey?.descriptor as? Tagged<Int, String>
                expect(descriptor?.tag) == "tag"
            }
        }
        context("multiple bindings") {
            var swinject: Swinject!
            var bindings = [AnyBindingMock]()
            var keys = [AnyBindingKeyMock]()
            beforeEach {
                keys = Array(0 ..< 3).map { _ in AnyBindingKeyMock() }
                keys.forEach { $0.matchesReturnValue = false }
                bindings = keys.map { _ in AnyBindingMock() }
                swinject = Swinject {
                    BindingEntry<Any>(key: keys[0], binding: bindings[0])
                    BindingEntry<Any>(key: keys[1], binding: bindings[1])
                    BindingEntry<Any>(key: keys[2], binding: bindings[2])
                }
            }
            it("throws if multiple entries match requested type") {
                keys.forEach { $0.matchesReturnValue = true }
                expect { try swinject.instance(of: Any.self) }.to(throwError())
            }
            it("does not throw if single entry matches requested type") {
                keys[1].matchesReturnValue = true
                expect { try swinject.instance(of: Any.self) }.notTo(throwError())
            }
            it("returns instance from matching binding") {
                keys[1].matchesReturnValue = true
                bindings[1].instanceArgContextResolverReturnValue = 42
                expect { try swinject.instance(of: Int.self) } == 42
            }
        }
    }
    describe("provider injection") {
        var swinject: Swinject!
        var binding = AnyBindingMock()
        var key = AnyBindingKeyMock()
        beforeEach {
            binding = AnyBindingMock()
            key = AnyBindingKeyMock()
            swinject = Swinject { BindingEntry<Any>(key: key, binding: binding) }
        }
        it("does not throw if binding matches provided type") {
            key.matchesReturnValue = true
            binding.instanceArgContextResolverReturnValue = 42
            let provider = swinject.provider() as () throws -> Int
            expect { try provider() }.notTo(throwError())
        }
        it("throws if missing binding for provided type") {
            key.matchesReturnValue = false
            let provider = swinject.provider() as () throws -> Int
            expect { try provider() }.to(throwError())
        }
        it("does not request provided type until provider is called") {
            key.matchesReturnValue = true
            binding.instanceArgContextResolverReturnValue = 42
            _ = swinject.provider(of: Int.self)
            expect(binding.instanceArgContextResolverCallsCount) == 0
        }
        it("returns instance from binding") {
            key.matchesReturnValue = true
            binding.instanceArgContextResolverReturnValue = 42
            let provider = swinject.provider(of: Int.self)
            expect { try provider() } == 42
        }
        it("rethrows binding error from provider") {
            key.matchesReturnValue = true
            binding.instanceArgContextResolverThrowableError = TestError()
            let provider = swinject.provider(of: Int.self)
            expect { try provider() }.to(throwError(errorType: TestError.self))
        }
        it("matches binding with correct key") {
            key.matchesReturnValue = true
            _ = try? swinject.provider(of: Any.self, tagged: "tag")()
            let otherKey = key.matchesReceivedOther as? BindingKey<Tagged<Any, String>, Void, Void>
            let descriptor = otherKey?.descriptor as? Tagged<Any, String>
            expect(descriptor?.tag) == "tag"
        }
    }
    describe("factory injection") {
        var swinject: Swinject!
        var binding = AnyBindingMock()
        var key = AnyBindingKeyMock()
        beforeEach {
            binding = AnyBindingMock()
            key = AnyBindingKeyMock()
            swinject = Swinject { BindingEntry<Any>(key: key, binding: binding) }
        }
        it("throws if missing binding for created type") {
            key.matchesReturnValue = false
            let factory = swinject.factory() as (String) throws -> Int
            expect { try factory("arg") }.to(throwError())
        }
        it("does not throw if binding matches created type") {
            key.matchesReturnValue = true
            binding.instanceArgContextResolverReturnValue = 42
            let factory = swinject.factory() as (String) throws -> Int
            expect { try factory("arg") }.notTo(throwError())
        }
        it("does not request created type until factory is called") {
            key.matchesReturnValue = true
            binding.instanceArgContextResolverReturnValue = 42
            _ = swinject.factory() as (String) throws -> Int
            expect(binding.instanceArgContextResolverCallsCount) == 0
        }
        it("rethrows binding error from factory") {
            key.matchesReturnValue = true
            binding.instanceArgContextResolverThrowableError = TestError()
            let factory = swinject.factory() as (String) throws -> Int
            expect { try factory("arg") }.to(throwError(errorType: TestError.self))
        }
        it("returns instance from binding") {
            key.matchesReturnValue = true
            binding.instanceArgContextResolverReturnValue = 42
            let factory = swinject.factory() as (String) throws -> Int
            expect { try factory("arg") } == 42
        }
        it("passes given factory argument to binding") {
            key.matchesReturnValue = true
            binding.instanceArgContextResolverReturnValue = 42
            _ = try? swinject.factory(of: Int.self)("arg")
            expect(binding.instanceArgContextResolverReceivedArguments?.arg as? String) == "arg"
        }
        it("matches binding with correct key") {
            key.matchesReturnValue = false
            _ = try? swinject.factory(tagged: "tag")("arg") as Int
            let otherKey = key.matchesReceivedOther as? BindingKey<Tagged<Int, String>, Void, String>
            let descriptor = otherKey?.descriptor as? Tagged<Int, String>
            expect(descriptor?.tag) == "tag"
        }
        context("currying") {
            beforeEach {
                key.matchesReturnValue = true
                binding.instanceArgContextResolverReturnValue = 42
            }
            it("can curry 2-tuple as argument") {
                _ = try? swinject.factory(arg: "arg1")("arg2") as Int
                let receivedArg = binding.instanceArgContextResolverReceivedArguments?.arg as? (String, String)
                expect(receivedArg?.0) == "arg1"
                expect(receivedArg?.1) == "arg2"
            }
            it("can curry 3-tuple as 1 / 2 argument") {
                _ = try? swinject.factory(arg: "arg1")(2, "arg3") as Int
                let receivedArg = binding.instanceArgContextResolverReceivedArguments?.arg as? (String, Int, String)
                expect(receivedArg?.0) == "arg1"
                expect(receivedArg?.1) == 2
                expect(receivedArg?.2) == "arg3"
            }
            it("can curry 3-tuple as 2 / 1 argument") {
                _ = try? swinject.factory(args: "arg1", 2)("arg3") as Int
                let receivedArg = binding.instanceArgContextResolverReceivedArguments?.arg as? (String, Int, String)
                expect(receivedArg?.0) == "arg1"
                expect(receivedArg?.1) == 2
                expect(receivedArg?.2) == "arg3"
            }
        }
    }
} }
