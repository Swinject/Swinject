//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Quick
import Nimble
@testable import Swinject3

class ModuleBuilderSpec: QuickSpec { override func spec() {
    it("builds empty function") {
        @ModuleBuilder func build() -> [ModuleEntry] {

        }
        expect(build().count) == 0
    }
    it("builds function with single entry") {
        @ModuleBuilder func build() -> [ModuleEntry] {
            AnyEntry()
        }
        expect(build().count) == 1
    }
    it("builds function with multiple entries") {
        @ModuleBuilder func build() -> [ModuleEntry] {
            AnyEntry(); AnyEntry(); AnyEntry(); AnyEntry(); AnyEntry()
        }
        expect(build().count) == 5
    }
    it("builds function with if statement") {
        @ModuleBuilder func build(_ flag: Bool) -> [ModuleEntry] {
            if flag { AnyEntry() }
        }
        expect(build(true).count) == 1
        expect(build(false).count) == 0
    }
    it("builds function with nested if statement") {
        @ModuleBuilder func build(_ flag1: Bool, _ flag2: Bool) -> [ModuleEntry] {
            if flag1 {
                AnyEntry()
                if flag2 { AnyEntry() }
            }
        }
        expect(build(true, true).count) == 2
        expect(build(true, false).count) == 1
    }
    it("builds function with if else statement") {
        @ModuleBuilder func build(_ flag: Bool) -> [ModuleEntry] {
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

struct AnyEntry: ModuleEntry {}
