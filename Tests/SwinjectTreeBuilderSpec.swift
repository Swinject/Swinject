//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Quick
import Nimble
@testable import Swinject

class SwinjectTreeBuilderSpec: QuickSpec { override func spec() {
    describe("allowed syntax") {
        it("builds empty closure") {
            let tree = makeTree { }
            expect(tree.bindingEntries).to(beEmpty())
        }
        it("builds closure with single entry") {
            let tree = makeTree { DummyBindingEntry() }
            expect(tree.bindingEntries.count) == 1
        }
        it("builds closure with multiple entries") {
            let tree = makeTree {
                DummyBindingEntry(); DummyBindingEntry(); DummyBindingEntry(); DummyBindingEntry(); DummyBindingEntry()
            }
            expect(tree.bindingEntries.count) == 5
        }
        it("builds closure with if statement") {
            let tree = makeTree  {
                if true { DummyBindingEntry() }
            }
            expect(tree.bindingEntries.count) == 1
        }
        it("builds closure with nested if statement") {
            let tree = makeTree {
                if true { DummyBindingEntry(); if true { DummyBindingEntry() } }
            }
            expect(tree.bindingEntries.count) == 2
        }
        it("builds closure with if else statement") {
            let tree = makeTree {
                if false { } else { DummyBindingEntry(); DummyBindingEntry() }
            }
            expect(tree.bindingEntries.count) == 2
        }
        it("builds closure with binding & include entries") {
            let tree = makeTree {
                DummyIncludeEntry()
                DummyIncludeEntry()
                DummyBindingEntry()
                DummyBindingEntry()
                DummyBindingEntry()
            }
            expect(tree.includeEntries.count) == 2
            expect(tree.bindingEntries.count) == 3
        }
    }
}}

// TODO: Return SwinjectTree directly from builder once full support for @functionBuilder is available
func makeTree(@SwinjectTreeBuilder builder: () -> [SwinjectEntry]) -> SwinjectTree {
    SwinjectTreeBuilder.buildFunction(builder())
}

func makeTree(@SwinjectTreeBuilder builder: () -> SwinjectEntry) -> SwinjectTree {
    SwinjectTreeBuilder.buildFunction([builder()])
}

func makeTree(@SwinjectTreeBuilder builder: () -> Void) -> SwinjectTree {
    SwinjectTreeBuilder.buildFunction([])
}
