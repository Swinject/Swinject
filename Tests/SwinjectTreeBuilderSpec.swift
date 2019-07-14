//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Quick
import Nimble
@testable import Swinject

class SwinjectTreeBuilderSpec: QuickSpec { override func spec() {
    it("builds empty function") {
        @SwinjectTreeBuilder func build() -> [SwinjectEntry] {

        }
        expect(build().count) == 0
    }
    it("builds function with single entry") {
        @SwinjectTreeBuilder func build() -> [SwinjectEntry] {
            AnyEntry()
        }
        expect(build().count) == 1
    }
    it("builds function with multiple entries") {
        @SwinjectTreeBuilder func build() -> [SwinjectEntry] {
            AnyEntry(); AnyEntry(); AnyEntry(); AnyEntry(); AnyEntry()
        }
        expect(build().count) == 5
    }
    it("builds function with if statement") {
        @SwinjectTreeBuilder func build(_ flag: Bool) -> [SwinjectEntry] {
            if flag { AnyEntry() }
        }
        expect(build(true).count) == 1
        expect(build(false).count) == 0
    }
    it("builds function with nested if statement") {
        @SwinjectTreeBuilder func build(_ flag1: Bool, _ flag2: Bool) -> [SwinjectEntry] {
            if flag1 {
                AnyEntry()
                if flag2 { AnyEntry() }
            }
        }
        expect(build(true, true).count) == 2
        expect(build(true, false).count) == 1
    }
    it("builds function with if else statement") {
        @SwinjectTreeBuilder func build(_ flag: Bool) -> [SwinjectEntry] {
            if flag {
                AnyEntry()
            } else {
                AnyEntry(); AnyEntry()
            }
        }
        expect(build(true).count) == 1
        expect(build(false).count) == 2
    }
}}

struct AnyEntry: SwinjectEntry {}
