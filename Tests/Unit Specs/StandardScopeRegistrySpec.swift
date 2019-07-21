//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class StandardScopeRegistrySpec: QuickSpec { override func spec() {
    var registry: StandardScopeRegistry!
    let key = (1 ... 5).map { ScopeRegistryKey(descriptor: plain(Int.self), argument: AnyMatchable($0)) }
    var closable = [ClosableMock]()
    beforeEach {
        closable = (1 ... 3).map { _ in ClosableMock() }
        registry = StandardScopeRegistry()
    }
    describe("instance") {
        var builderCallCount = 0
        let countingBuilder: () -> Any = { builderCallCount += 1; return 0 }
        beforeEach {
            builderCallCount = 0
        }
        it("calls builder on first invocation for key") {
            _ = registry.instance(for: key[0], builder: countingBuilder)
            expect(builderCallCount) == 1
        }
        it("calls builder only once for each key") {
            _ = registry.instance(for: key[0], builder: countingBuilder)
            _ = registry.instance(for: key[1], builder: countingBuilder)
            _ = registry.instance(for: key[0], builder: countingBuilder)
            _ = registry.instance(for: key[1], builder: countingBuilder)
            expect(builderCallCount) == 2
        }
        it("rethtrows error from builder") {
            expect {
                try registry.instance(for: key[0]) { throw TestError() }
            }.to(throwError(errorType: TestError.self))
        }
        it("returns result of builder for first invocation") {
            expect(registry.instance(for: key[0]) { 42 } as? Int) == 42
        }
        it("returns result of builder on second invocation") {
            _ = registry.instance(for: key[0]) { 42 }
            _ = registry.instance(for: key[1]) { 25 }
            expect(registry.instance(for: key[0]) { 0 } as? Int) == 42
            expect(registry.instance(for: key[1]) { 0 } as? Int) == 25
        }
    }
    describe("clear") {
        it("closes instances when cleared") {
            _ = registry.instance(for: key[0]) { closable[0] }
            _ = registry.instance(for: key[1]) { closable[1] }
            registry.clear()
            expect(closable[0].closeCallsCount) == 1
            expect(closable[1].closeCallsCount) == 1
        }
        it("releases instance references when cleared") {
            var human: Human? = Human()
            weak var weakRef = human
            _ = registry.instance(for: key[0]) { human! }
            registry.clear()
            human = nil
            expect(weakRef).to(beNil())
        }
    }
    describe("closable") {
        it("does not close instance by default") {
            _ = registry.instance(for: key[0]) { closable[0] }
            expect(closable[0].closeCallsCount) == 0
        }
        it("closes instances when closed") {
            _ = registry.instance(for: key[0]) { closable[0] }
            _ = registry.instance(for: key[1]) { closable[1] }
            registry.close()
            expect(closable[0].closeCallsCount) == 1
            expect(closable[1].closeCallsCount) == 1
        }
        it("releases instance references when closed") {
            var human: Human? = Human()
            weak var weakRef = human
            _ = registry.instance(for: key[0]) { human! }
            registry.close()
            human = nil
            expect(weakRef).to(beNil())
        }
    }
    describe("deinit") {
        it("closes instances on deinit") {
            _ = registry.instance(for: key[0]) { closable[0] }
            _ = registry.instance(for: key[1]) { closable[1] }
            registry = nil
            expect(closable[0].closeCallsCount) == 1
            expect(closable[1].closeCallsCount) == 1
        }
    }
    describe("concurrency") {
        it("calls builder only once when invoked concurrently multiple times") {
            var builderCallCount = 0
            concurrentPerform(iterations: 5) {
                _ = registry.instance(for: key[0]) {
                    Thread.sleep(forTimeInterval: 0.1)
                    builderCallCount += 1
                    return 0
                }
            }
            expect(builderCallCount) == 1
        }
        it("closes instance only once when closed concurrently multiple times") {
            let closable = ClosableMock()
            closable.closeClosure = { Thread.sleep(forTimeInterval: 0.1) }
            _ = registry.instance(for: key[0]) { closable }
            concurrentPerform(iterations: 5, action: registry.close)
            expect(closable.closeCallsCount) == 1
        }
    }
} }
