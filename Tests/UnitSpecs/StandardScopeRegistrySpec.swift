//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class StandardScopeRegistrySpec: QuickSpec { override func spec() {
    var registry: StandardScopeRegistry!
    let person = Array(1 ... 3).map { _ in Person() }
    let key = Array(1 ... 3).map { ScopeRegistryKey(descriptor: plain(Int.self), argument: AnyMatchable($0)) }
    beforeEach {
        registry = StandardScopeRegistry()
    }
    describe("empty") {
        it("returns no instance") {
            expect(registry.instance(for: key[0])).to(beNil())
        }
    }
    describe("single intance") {
        beforeEach {
            registry.register(person[0], for: key[0])
        }
        it("returns instance for correct key") {
            expect(registry.instance(for: key[0])) === person[0]
        }
        it("returns no instance for incorrect key") {
            expect(registry.instance(for: key[1])).to(beNil())
        }
    }
    describe("multiple intances") {
        it("returns different instances for different keys") {
            registry.register(person[0], for: key[0])
            registry.register(person[1], for: key[1])
            expect(registry.instance(for: key[0])) === person[0]
            expect(registry.instance(for: key[1])) === person[1]
        }
        it("returns the last instance registered for the key") {
            registry.register(person[0], for: key[0])
            registry.register(person[1], for: key[0])
            expect(registry.instance(for: key[0])) === person[1]
        }
        it("should keep references to all registerd instances") {
            var aPerson = Person() as Person?
            weak var weakRef = aPerson
            registry.register(aPerson!, for: key[0])
            registry.register(person[0], for: key[0])
            aPerson = nil
            expect(weakRef).notTo(beNil())
        }
    }
} }
