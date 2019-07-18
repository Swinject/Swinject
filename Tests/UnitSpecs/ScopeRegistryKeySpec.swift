//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class ScopeRegistryKeySpec: QuickSpec { override func spec() {
    var descriptor1 = AnyTypeDescriptorMock()
    var descriptor2 = AnyTypeDescriptorMock()
    var argument1 = MatchableMock()
    var argument2 = MatchableMock()
    var key1: ScopeRegistryKey!
    var key2: ScopeRegistryKey!
    beforeEach {
        descriptor1 = AnyTypeDescriptorMock()
        descriptor1.matchesReturnValue = true
        descriptor1.hashValue = 0
        argument1 = MatchableMock()
        argument1.matchesReturnValue = true
        argument1.hashValue = 0
        descriptor2 = AnyTypeDescriptorMock()
        descriptor2.matchesReturnValue = true
        descriptor2.hashValue = 0
        argument2 = MatchableMock()
        argument2.matchesReturnValue = true
        argument2.hashValue = 0
        key1 = ScopeRegistryKey(descriptor: descriptor1, argument: argument1)
        key2 = ScopeRegistryKey(descriptor: descriptor2, argument: argument2)
    }
    describe("equality") {
        describe("descriptor matching") {
            it("does not equal if first descriptor doesnt match") {
                descriptor1.matchesReturnValue = false
                descriptor2.matchesReturnValue = true
                expect(key1) != key2
            }
            it("does not equal if second descriptor doesnt match") {
                descriptor1.matchesReturnValue = true
                descriptor2.matchesReturnValue = false
                expect(key1) != key2
            }
            it("equals if both descriptor match") {
                descriptor1.matchesReturnValue = true
                descriptor2.matchesReturnValue = true
                expect(key1) == key2
            }
        }
        describe("argument matching") {
            it("does not equal if first argument is not matchable") {
                key1 = ScopeRegistryKey(descriptor: descriptor1, argument: ())
                expect(key1) != key2
            }
            it("does not equal if first argument doesnt match") {
                argument1.matchesReturnValue = false
                expect(key1) != key2
            }
            it("does not equal if second argument is not matchable") {
                key2 = ScopeRegistryKey(descriptor: descriptor2, argument: ())
                expect(key1) != key2
            }
            it("does not equal if second argument doesnt match") {
                argument2.matchesReturnValue = false
                expect(key1) != key2
            }
            it("equals if both arguments match") {
                argument1.matchesReturnValue = true
                argument2.matchesReturnValue = true
                expect(key1) == key2
            }
        }
    }
    describe("hash") {
        describe("hashes descriptor") {
            it("does not equal if descriptor hashes are different") {
                descriptor1.hashValue = 1
                descriptor2.hashValue = 2
                expect(key1.hashValue) != key2.hashValue
            }
            it("equals if descriptor hashes are the same") {
                descriptor1.hashValue = 1
                descriptor2.hashValue = 1
                expect(key1.hashValue) == key2.hashValue
            }
        }
        describe("hashes matchable argument") {
            it("does not equal if argument hashes are different") {
                argument1.hashValue = 1
                argument2.hashValue = 2
                expect(key1.hashValue) != key2.hashValue
            }
            it("equals if argument hashes are the same") {
                argument1.hashValue = 1
                argument2.hashValue = 1
                expect(key1.hashValue) == key2.hashValue
            }
        }
    }
} }
