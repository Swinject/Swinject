//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Foundation
import Nimble
import Quick
@testable import Swinject

class StandardScopeRegistrySpec: QuickSpec { override func spec() {
    var registry: StandardScopeRegistry!
    let key = (1 ... 5).map { ScopeRegistryKey(descriptor: tagged(Int.self, with: "\($0)"), argument: ()) }
    var doors = [Door]()
    beforeEach {
        doors = (1 ... 3).map { _ in Door() }
        registry = StandardScopeRegistry()
    }
    describe("instance") {
        var builderCallCount = 0
        var finalizerCallCount = 0
        let countingBuilder: () -> Reference<Any> = { builderCallCount += 1; return strongRef(0) }
        let countingFinalizer: (Any) -> Void = { _ in finalizerCallCount += 1 }
        beforeEach {
            builderCallCount = 0
            finalizerCallCount = 0
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
        it("calls builder every time if reference returns nil for next value") {
            let noRefBuilder: () -> Reference<Any> = { builderCallCount += 1; return noRef(0) }
            _ = registry.instance(for: key[0], builder: noRefBuilder)
            _ = registry.instance(for: key[1], builder: noRefBuilder)
            _ = registry.instance(for: key[0], builder: noRefBuilder)
            _ = registry.instance(for: key[1], builder: noRefBuilder)
            expect(builderCallCount) == 4
        }
        it("does not call builder's nextValue before second invocation") {
            var nextValueCalled = false
            _ = registry.instance(for: key[0]) {
                Reference(currentValue: 42) { nextValueCalled = true; return 0 }
            }
            expect(nextValueCalled) == false
        }
        it("does not keep reference on builder's currentValue") {
            var human = Human() as Human?
            weak var weakRef = human
            _ = registry.instance(for: key[0]) { Reference(currentValue: human!, nextValue: { nil }) }
            human = nil
            expect(weakRef).to(beNil())
        }
        it("rethtrows error from builder") {
            expect {
                try registry.instance(for: key[0]) { throw TestError() }
            }.to(throwError(errorType: TestError.self))
        }
        it("returns result of builder's currentValue for first invocation") {
            let builder: () -> Reference<Any> = { Reference(currentValue: 42, nextValue: { 0 }) }
            expect(registry.instance(for: key[0], builder: builder) as? Int) == 42
        }
        it("returns result of builder's next value on second invocation") {
            _ = registry.instance(for: key[0]) { Reference(currentValue: 0, nextValue: { 42 }) }
            _ = registry.instance(for: key[1]) { Reference(currentValue: 0, nextValue: { 25 }) }
            expect(registry.instance(for: key[0]) { strongRef(0) } as? Int) == 42
            expect(registry.instance(for: key[1]) { strongRef(0) } as? Int) == 25
        }
        it("calls finalizer on first invocation for key") {
            _ = registry.instance(for: key[0], builder: { strongRef(0) }, finalizer: countingFinalizer)
            expect(finalizerCallCount) == 1
        }
        it("rethrows error from finalizer") {
            expect {
                try registry.instance(for: key[0], builder: { strongRef(0) }, finalizer: { _ in throw TestError() })
            }.to(throwError(errorType: TestError.self))
        }
        it("calls finalizer with instance from builder") {
            var instance: Any?
            _ = registry.instance(for: key[0], builder: { strongRef(42) }, finalizer: { instance = $0 })
            expect(instance as? Int) == 42
        }
        it("only calls finalizer on first invocation for each key") {
            _ = registry.instance(for: key[0], builder: { strongRef(0) }, finalizer: countingFinalizer)
            _ = registry.instance(for: key[1], builder: { strongRef(0) }, finalizer: countingFinalizer)
            _ = registry.instance(for: key[0], builder: { strongRef(0) }, finalizer: countingFinalizer)
            _ = registry.instance(for: key[1], builder: { strongRef(0) }, finalizer: countingFinalizer)
            expect(finalizerCallCount) == 2
        }
        it("returns the last instance if the same key was used from builder") {
            let instance = registry.instance(
                for: key[0],
                builder: {
                    _ = registry.instance(for: key[0], builder: { strongRef(42) })
                    return strongRef(0)
                },
                finalizer: { _ in }
            )
            expect(instance as? Int) == 42
        }
        it("calls builder only once if the same key was used from finalizer") {
            _ = registry.instance(for: key[0], builder: countingBuilder) { _ in
                _ = registry.instance(for: key[0], builder: countingBuilder, finalizer: { _ in })
            }
            expect(builderCallCount) == 1
        }
    }
    describe("clear") {
        it("closes instances when cleared") {
            _ = registry.instance(for: key[0]) { strongRef(doors[0]) }
            _ = registry.instance(for: key[1]) { strongRef(doors[1]) }
            registry.clear()
            expect(doors[0].closeCount) == 1
            expect(doors[1].closeCount) == 1
        }
        it("releases instance references when cleared") {
            var human: Human? = Human()
            weak var weakRef = human
            _ = registry.instance(for: key[0]) { strongRef(human!) }
            registry.clear()
            human = nil
            expect(weakRef).to(beNil())
        }
    }
    describe("closable") {
        it("does not close instance by default") {
            _ = registry.instance(for: key[0]) { strongRef(doors[0]) }
            expect(doors[0].isClosed) == false
        }
        it("closes instances when closed") {
            _ = registry.instance(for: key[0]) { strongRef(doors[0]) }
            _ = registry.instance(for: key[1]) { strongRef(doors[1]) }
            registry.close()
            expect(doors[0].closeCount) == 1
            expect(doors[1].closeCount) == 1
        }
        it("releases instance references when closed") {
            var human: Human? = Human()
            weak var weakRef = human
            _ = registry.instance(for: key[0]) { strongRef(human!) }
            registry.close()
            human = nil
            expect(weakRef).to(beNil())
        }
    }
    describe("deinit") {
        it("closes instances on deinit") {
            _ = registry.instance(for: key[0]) { strongRef(doors[0]) }
            _ = registry.instance(for: key[1]) { strongRef(doors[1]) }
            registry = nil
            expect(doors[0].closeCount) == 1
            expect(doors[1].closeCount) == 1
        }
    }
    describe("concurrency") {
        it("calls builder only once when invoked concurrently multiple times") {
            var builderCallCount = 0
            concurrentPerform(iterations: 5) {
                _ = registry.instance(for: key[0]) {
                    Thread.sleep(forTimeInterval: 0.1)
                    builderCallCount += 1
                    return strongRef(0)
                }
            }
            expect(builderCallCount) == 1
        }
        it("closes instance only once when closed concurrently multiple times") {
            let door = Door()
            door.whenClosed = { Thread.sleep(forTimeInterval: 0.1) }
            _ = registry.instance(for: key[0]) { strongRef(door) }
            concurrentPerform(iterations: 5, action: registry.close)
            expect(door.closeCount) == 1
        }
        it("does not deadlock if invoked inside builder") {
            waitUntil { done in
                DispatchQueue.global(qos: .background).async {
                    _ = registry.instance(for: key[0]) {
                        strongRef(registry.instance(for: key[1]) { strongRef(42) })
                    }
                    done()
                }
            }
        }
    }
} }
