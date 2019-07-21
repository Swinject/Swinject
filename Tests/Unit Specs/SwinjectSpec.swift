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
            var binding = BindingMock()
            beforeEach {
                binding = BindingMock()
                swinject = Swinject { binding }
            }
            it("request instance from matching binding") {
                binding.matchesReturnValue = true
                _ = try? swinject.instance(of: Any.self)
                expect(binding.instanceArgContextResolver3CallsCount) == 1
            }
            it("does not request instance from matching binding until instance is required") {
                binding.matchesReturnValue = true
                expect(binding.instanceArgContextResolver3CallsCount) == 0
            }
            it("only requests instance from matching binding") {
                binding.matchesReturnValue = false
                _ = try? swinject.instance(of: Any.self)
                expect(binding.instanceArgContextResolver3CallsCount) == 0
            }
            it("returns instance produced by binding") {
                binding.matchesReturnValue = true
                binding.instanceArgContextResolver3ReturnValue = 42
                expect { try swinject.instance(of: Any.self) as? Int } == 42
            }
            it("rethrows error from binding") {
                binding.matchesReturnValue = true
                binding.instanceArgContextResolver3ThrowableError = TestError()
                expect { try swinject.instance(of: Any.self) }.to(throwError(errorType: TestError.self))
            }
            it("crashes if bound type does not match requested type") {
                binding.matchesReturnValue = true
                binding.instanceArgContextResolver3ReturnValue = ""
                expect { _ = try swinject.instance(of: Double.self) }.to(throwError())
            }
            it("does not crash if bound type conforms to the requested type") {
                binding.matchesReturnValue = true
                binding.instanceArgContextResolver3ReturnValue = 42
                expect { _ = try swinject.instance(of: CustomStringConvertible?.self) }.notTo(throwError())
            }
            it("passes swinject as resolver") {
                binding.matchesReturnValue = true
                _ = try? swinject.instance(of: Any.self)
                expect(binding.instanceArgContextResolver3ReceivedArguments?.resolver is Swinject).to(beTrue())
            }
            it("matches binding with correct key") {
                binding.matchesReturnValue = false
                _ = try? swinject.instance(tagged: "tag") as Int
                let otherKey = binding.matchesReceivedKey as? BindingKey<Tagged<Int, String>, Void, Void>
                let descriptor = otherKey?.descriptor as? Tagged<Int, String>
                expect(descriptor?.tag) == "tag"
            }
            it("matches binding with correct context") {
                binding.matchesReturnValue = false
                _ = try? swinject.on("context").instance() as Int
                expect(binding.matchesReceivedKey?.contextType is String.Type).to(beTrue())
            }
        }
        context("multiple bindings") {
            var swinject: Swinject!
            var bindings = [BindingMock]()
            beforeEach {
                bindings = Array(0 ..< 3).map { _ in BindingMock() }
                bindings.forEach { $0.matchesReturnValue = false }
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
                bindings[1].instanceArgContextResolver3ReturnValue = 42
                expect { try swinject.instance(of: Int.self) } == 42
            }
        }
    }
    describe("provider injection") {
        var swinject: Swinject!
        var binding = BindingMock()
        beforeEach {
            binding = BindingMock()
            swinject = Swinject { binding }
        }
        it("does not throw if binding matches provided type") {
            binding.matchesReturnValue = true
            binding.instanceArgContextResolver3ReturnValue = 42
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
            binding.instanceArgContextResolver3ReturnValue = 42
            _ = swinject.provider(of: Int.self)
            expect(binding.instanceArgContextResolver3CallsCount) == 0
        }
        it("returns instance from binding") {
            binding.matchesReturnValue = true
            binding.instanceArgContextResolver3ReturnValue = 42
            let provider = swinject.provider(of: Int.self)
            expect { try provider() } == 42
        }
        it("rethrows binding error from provider") {
            binding.matchesReturnValue = true
            binding.instanceArgContextResolver3ThrowableError = TestError()
            let provider = swinject.provider(of: Int.self)
            expect { try provider() }.to(throwError(errorType: TestError.self))
        }
        it("matches binding with correct key") {
            binding.matchesReturnValue = true
            _ = try? swinject.provider(of: Any.self, tagged: "tag")()
            let otherKey = binding.matchesReceivedKey as? BindingKey<Tagged<Any, String>, Void, Void>
            let descriptor = otherKey?.descriptor as? Tagged<Any, String>
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
            expect(binding.instanceArgContextResolver3ReceivedArguments?.context as? String) == "context"
        }
    }
    describe("factory injection") {
        var swinject: Swinject!
        var binding = BindingMock()
        beforeEach {
            binding = BindingMock()
            swinject = Swinject { binding }
        }
        it("throws if missing binding for created type") {
            binding.matchesReturnValue = false
            let factory = swinject.factory() as (String) throws -> Int
            expect { try factory("arg") }.to(throwError())
        }
        it("does not throw if binding matches created type") {
            binding.matchesReturnValue = true
            binding.instanceArgContextResolver3ReturnValue = 42
            let factory = swinject.factory() as (String) throws -> Int
            expect { try factory("arg") }.notTo(throwError())
        }
        it("does not request created type until factory is called") {
            binding.matchesReturnValue = true
            binding.instanceArgContextResolver3ReturnValue = 42
            _ = swinject.factory() as (String) throws -> Int
            expect(binding.instanceArgContextResolver3CallsCount) == 0
        }
        it("rethrows binding error from factory") {
            binding.matchesReturnValue = true
            binding.instanceArgContextResolver3ThrowableError = TestError()
            let factory = swinject.factory() as (String) throws -> Int
            expect { try factory("arg") }.to(throwError(errorType: TestError.self))
        }
        it("returns instance from binding") {
            binding.matchesReturnValue = true
            binding.instanceArgContextResolver3ReturnValue = 42
            let factory = swinject.factory() as (String) throws -> Int
            expect { try factory("arg") } == 42
        }
        it("passes given factory argument to binding") {
            binding.matchesReturnValue = true
            binding.instanceArgContextResolver3ReturnValue = 42
            _ = try? swinject.factory(of: Int.self)("arg")
            expect(binding.instanceArgContextResolver3ReceivedArguments?.arg as? String) == "arg"
        }
        it("matches binding with correct key") {
            binding.matchesReturnValue = false
            _ = try? swinject.factory(tagged: "tag")("arg") as Int
            let otherKey = binding.matchesReceivedKey as? BindingKey<Tagged<Int, String>, Void, String>
            let descriptor = otherKey?.descriptor as? Tagged<Int, String>
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
            expect(binding.instanceArgContextResolver3ReceivedArguments?.context as? String) == "context"
        }
        context("currying") {
            beforeEach {
                binding.matchesReturnValue = true
                binding.instanceArgContextResolver3ReturnValue = 42
            }
            it("can curry 2-tuple as 0 / 2 argument") {
                _ = try? swinject.factory()("arg1", "arg2") as Int
                let receivedArg = binding.instanceArgContextResolver3ReceivedArguments?.arg as? (String, String)
                expect(receivedArg?.0) == "arg1"
                expect(receivedArg?.1) == "arg2"
            }
            it("can curry 2-tuple as 1 / 1 argument") {
                _ = try? swinject.factory(arg: "arg1")("arg2") as Int
                let receivedArg = binding.instanceArgContextResolver3ReceivedArguments?.arg as? (String, String)
                expect(receivedArg?.0) == "arg1"
                expect(receivedArg?.1) == "arg2"
            }
            it("can curry 3-tuple as 0 / 3 argument") {
                _ = try? swinject.factory()("arg1", 2, "arg3") as Int
                let receivedArg = binding.instanceArgContextResolver3ReceivedArguments?.arg as? (String, Int, String)
                expect(receivedArg?.0) == "arg1"
                expect(receivedArg?.1) == 2
                expect(receivedArg?.2) == "arg3"
            }
            it("can curry 3-tuple as 1 / 2 argument") {
                _ = try? swinject.factory(arg: "arg1")(2, "arg3") as Int
                let receivedArg = binding.instanceArgContextResolver3ReceivedArguments?.arg as? (String, Int, String)
                expect(receivedArg?.0) == "arg1"
                expect(receivedArg?.1) == 2
                expect(receivedArg?.2) == "arg3"
            }
            it("can curry 3-tuple as 2 / 1 argument") {
                _ = try? swinject.factory(args: "arg1", 2)("arg3") as Int
                let receivedArg = binding.instanceArgContextResolver3ReceivedArguments?.arg as? (String, Int, String)
                expect(receivedArg?.0) == "arg1"
                expect(receivedArg?.1) == 2
                expect(receivedArg?.2) == "arg3"
            }
        }
    }
} }
