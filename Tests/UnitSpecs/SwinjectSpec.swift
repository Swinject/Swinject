//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class SwinjectSpec: QuickSpec { override func spec() {
    describe("instance injection") {
        context("no makers") {
            it("throws") {
                let swinject = Swinject {}
                expect { try swinject.instance(of: Int.self) }.to(throwError())
            }
        }
        context("single maker") {
            var swinject: Swinject!
            var maker = AnyInstanceMakerMock()
            var key = AnyBindingKeyMock()
            beforeEach {
                maker = AnyInstanceMakerMock()
                key = AnyBindingKeyMock()
                swinject = Swinject { SimpleBinding(key: key, maker: maker) }
            }
            it("request instance from matching maker") {
                key.matchesReturnValue = true
                _ = try? swinject.instance(of: Any.self)
                expect(maker.makeInstanceArgContextResolverCallsCount) == 1
            }
            it("does not request instance from matching maker until instance is required") {
                key.matchesReturnValue = true
                expect(maker.makeInstanceArgContextResolverCallsCount) == 0
            }
            it("only requests instance from matching maker") {
                key.matchesReturnValue = false
                _ = try? swinject.instance(of: Any.self)
                expect(maker.makeInstanceArgContextResolverCallsCount) == 0
            }
            it("returns instance produced by maker") {
                key.matchesReturnValue = true
                maker.makeInstanceArgContextResolverReturnValue = 42
                expect { try swinject.instance(of: Any.self) as? Int } == 42
            }
            it("rethrows error from maker") {
                key.matchesReturnValue = true
                maker.makeInstanceArgContextResolverThrowableError = TestError()
                expect { try swinject.instance(of: Any.self) }.to(throwError(errorType: TestError.self))
            }
            it("crashes if bound type does not match requested type") {
                key.matchesReturnValue = true
                maker.makeInstanceArgContextResolverReturnValue = ""
                expect { _ = try swinject.instance(of: Double.self) }.to(throwError())
            }
            it("does not crash if bound type conforms to the requested type") {
                key.matchesReturnValue = true
                maker.makeInstanceArgContextResolverReturnValue = 42
                expect { _ = try swinject.instance(of: CustomStringConvertible?.self) }.notTo(throwError())
            }
            it("passes swinject as resolver") {
                key.matchesReturnValue = true
                _ = try? swinject.instance(of: Any.self)
                expect(maker.makeInstanceArgContextResolverReceivedArguments?.resolver is Swinject).to(beTrue())
            }
            it("matches maker with correct key") {
                key.matchesReturnValue = false
                _ = try? swinject.instance(tagged: "tag") as Int
                let otherKey = key.matchesReceivedOther as? BindingKey<Tagged<Int, String>, Void, Void>
                let descriptor = otherKey?.descriptor as? Tagged<Int, String>
                expect(descriptor?.tag) == "tag"
            }
            it("matches maker with correct context") {
                key.matchesReturnValue = false
                _ = try? swinject.on("context").instance() as Int
                expect(key.matchesReceivedOther?.contextType is String.Type).to(beTrue())
            }
        }
        context("multiple makers") {
            var swinject: Swinject!
            var makers = [AnyInstanceMakerMock]()
            var keys = [AnyBindingKeyMock]()
            beforeEach {
                keys = Array(0 ..< 3).map { _ in AnyBindingKeyMock() }
                keys.forEach { $0.matchesReturnValue = false }
                makers = keys.map { _ in AnyInstanceMakerMock() }
                swinject = Swinject {
                    SimpleBinding(key: keys[0], maker: makers[0])
                    SimpleBinding(key: keys[1], maker: makers[1])
                    SimpleBinding(key: keys[2], maker: makers[2])
                }
            }
            it("throws if multiple bindings match requested type") {
                keys.forEach { $0.matchesReturnValue = true }
                expect { try swinject.instance(of: Any.self) }.to(throwError())
            }
            it("does not throw if single binding matches requested type") {
                keys[1].matchesReturnValue = true
                expect { try swinject.instance(of: Any.self) }.notTo(throwError())
            }
            it("returns instance from matching maker") {
                keys[1].matchesReturnValue = true
                makers[1].makeInstanceArgContextResolverReturnValue = 42
                expect { try swinject.instance(of: Int.self) } == 42
            }
        }
    }
    describe("provider injection") {
        var swinject: Swinject!
        var maker = AnyInstanceMakerMock()
        var key = AnyBindingKeyMock()
        beforeEach {
            maker = AnyInstanceMakerMock()
            key = AnyBindingKeyMock()
            swinject = Swinject { SimpleBinding(key: key, maker: maker) }
        }
        it("does not throw if maker matches provided type") {
            key.matchesReturnValue = true
            maker.makeInstanceArgContextResolverReturnValue = 42
            let provider = swinject.provider() as () throws -> Int
            expect { try provider() }.notTo(throwError())
        }
        it("throws if missing maker for provided type") {
            key.matchesReturnValue = false
            let provider = swinject.provider() as () throws -> Int
            expect { try provider() }.to(throwError())
        }
        it("does not request provided type until provider is called") {
            key.matchesReturnValue = true
            maker.makeInstanceArgContextResolverReturnValue = 42
            _ = swinject.provider(of: Int.self)
            expect(maker.makeInstanceArgContextResolverCallsCount) == 0
        }
        it("returns instance from maker") {
            key.matchesReturnValue = true
            maker.makeInstanceArgContextResolverReturnValue = 42
            let provider = swinject.provider(of: Int.self)
            expect { try provider() } == 42
        }
        it("rethrows maker error from provider") {
            key.matchesReturnValue = true
            maker.makeInstanceArgContextResolverThrowableError = TestError()
            let provider = swinject.provider(of: Int.self)
            expect { try provider() }.to(throwError(errorType: TestError.self))
        }
        it("matches maker with correct key") {
            key.matchesReturnValue = true
            _ = try? swinject.provider(of: Any.self, tagged: "tag")()
            let otherKey = key.matchesReceivedOther as? BindingKey<Tagged<Any, String>, Void, Void>
            let descriptor = otherKey?.descriptor as? Tagged<Any, String>
            expect(descriptor?.tag) == "tag"
        }
        it("matches maker with correct context") {
            key.matchesReturnValue = false
            _ = try? swinject.on("context").provider()() as Int
            expect(key.matchesReceivedOther?.contextType is String.Type).to(beTrue())
        }
        it("passes given context to the bidndning") {
            key.matchesReturnValue = true
            _ = try? swinject.on("context").provider()() as Int
            expect(maker.makeInstanceArgContextResolverReceivedArguments?.context as? String) == "context"
        }
    }
    describe("factory injection") {
        var swinject: Swinject!
        var maker = AnyInstanceMakerMock()
        var key = AnyBindingKeyMock()
        beforeEach {
            maker = AnyInstanceMakerMock()
            key = AnyBindingKeyMock()
            swinject = Swinject { SimpleBinding(key: key, maker: maker) }
        }
        it("throws if missing maker for created type") {
            key.matchesReturnValue = false
            let factory = swinject.factory() as (String) throws -> Int
            expect { try factory("arg") }.to(throwError())
        }
        it("does not throw if maker matches created type") {
            key.matchesReturnValue = true
            maker.makeInstanceArgContextResolverReturnValue = 42
            let factory = swinject.factory() as (String) throws -> Int
            expect { try factory("arg") }.notTo(throwError())
        }
        it("does not request created type until factory is called") {
            key.matchesReturnValue = true
            maker.makeInstanceArgContextResolverReturnValue = 42
            _ = swinject.factory() as (String) throws -> Int
            expect(maker.makeInstanceArgContextResolverCallsCount) == 0
        }
        it("rethrows maker error from factory") {
            key.matchesReturnValue = true
            maker.makeInstanceArgContextResolverThrowableError = TestError()
            let factory = swinject.factory() as (String) throws -> Int
            expect { try factory("arg") }.to(throwError(errorType: TestError.self))
        }
        it("returns instance from maker") {
            key.matchesReturnValue = true
            maker.makeInstanceArgContextResolverReturnValue = 42
            let factory = swinject.factory() as (String) throws -> Int
            expect { try factory("arg") } == 42
        }
        it("passes given factory argument to maker") {
            key.matchesReturnValue = true
            maker.makeInstanceArgContextResolverReturnValue = 42
            _ = try? swinject.factory(of: Int.self)("arg")
            expect(maker.makeInstanceArgContextResolverReceivedArguments?.arg as? String) == "arg"
        }
        it("matches maker with correct key") {
            key.matchesReturnValue = false
            _ = try? swinject.factory(tagged: "tag")("arg") as Int
            let otherKey = key.matchesReceivedOther as? BindingKey<Tagged<Int, String>, Void, String>
            let descriptor = otherKey?.descriptor as? Tagged<Int, String>
            expect(descriptor?.tag) == "tag"
        }
        it("matches maker with correct context") {
            key.matchesReturnValue = false
            _ = try? swinject.on("context").factory()("arg") as Int
            expect(key.matchesReceivedOther?.contextType is String.Type).to(beTrue())
        }
        it("passes given context to the bidndning") {
            key.matchesReturnValue = true
            _ = try? swinject.on("context").factory()("arg") as Int
            expect(maker.makeInstanceArgContextResolverReceivedArguments?.context as? String) == "context"
        }
        context("currying") {
            beforeEach {
                key.matchesReturnValue = true
                maker.makeInstanceArgContextResolverReturnValue = 42
            }
            it("can curry 2-tuple as 0 / 2 argument") {
                _ = try? swinject.factory()("arg1", "arg2") as Int
                let receivedArg = maker.makeInstanceArgContextResolverReceivedArguments?.arg as? (String, String)
                expect(receivedArg?.0) == "arg1"
                expect(receivedArg?.1) == "arg2"
            }
            it("can curry 2-tuple as 1 / 1 argument") {
                _ = try? swinject.factory(arg: "arg1")("arg2") as Int
                let receivedArg = maker.makeInstanceArgContextResolverReceivedArguments?.arg as? (String, String)
                expect(receivedArg?.0) == "arg1"
                expect(receivedArg?.1) == "arg2"
            }
            it("can curry 3-tuple as 0 / 3 argument") {
                _ = try? swinject.factory()("arg1", 2, "arg3") as Int
                let receivedArg = maker.makeInstanceArgContextResolverReceivedArguments?.arg as? (String, Int, String)
                expect(receivedArg?.0) == "arg1"
                expect(receivedArg?.1) == 2
                expect(receivedArg?.2) == "arg3"
            }
            it("can curry 3-tuple as 1 / 2 argument") {
                _ = try? swinject.factory(arg: "arg1")(2, "arg3") as Int
                let receivedArg = maker.makeInstanceArgContextResolverReceivedArguments?.arg as? (String, Int, String)
                expect(receivedArg?.0) == "arg1"
                expect(receivedArg?.1) == 2
                expect(receivedArg?.2) == "arg3"
            }
            it("can curry 3-tuple as 2 / 1 argument") {
                _ = try? swinject.factory(args: "arg1", 2)("arg3") as Int
                let receivedArg = maker.makeInstanceArgContextResolverReceivedArguments?.arg as? (String, Int, String)
                expect(receivedArg?.0) == "arg1"
                expect(receivedArg?.1) == 2
                expect(receivedArg?.2) == "arg3"
            }
        }
    }
} }
