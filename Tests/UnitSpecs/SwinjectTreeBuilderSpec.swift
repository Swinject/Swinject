//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class SwinjectTreeBuilderSpec: QuickSpec { override func spec() {
    describe("allowed syntax") {
        it("builds empty closure") {
            let tree = makeTree {}
            expect(tree.makerEntries).to(beEmpty())
        }
        it("builds closure with single entry") {
            let tree = makeTree { AnyMakerEntryMock() }
            expect(tree.makerEntries.count) == 1
        }
        it("builds closure with multiple entries") {
            let tree = makeTree {
                AnyMakerEntryMock(); AnyMakerEntryMock(); AnyMakerEntryMock(); AnyMakerEntryMock(); AnyMakerEntryMock()
            }
            expect(tree.makerEntries.count) == 5
        }
        // FIXME: Test coverage enabled build segfaults on this
//        it("builds closure with if statement") {
//            let tree = makeTree {
//                if true { AnyMakerEntryMock() }
//            }
//            expect(tree.makerEntries.count) == 1
//        }
//        it("builds closure with nested if statement") {
//            let tree = makeTree {
//                if true { AnyMakerEntryMock(); if true { AnyMakerEntryMock() } }
//            }
//            expect(tree.makerEntries.count) == 2
//        }
//        it("builds closure with if else statement") {
//            let tree = makeTree {
//                if false {} else { AnyMakerEntryMock(); AnyMakerEntryMock() }
//            }
//            expect(tree.makerEntries.count) == 2
//        }
        it("builds closure with maker & include entries") {
            let tree = makeTree {
                ModuleIncludeEntryMock()
                ModuleIncludeEntryMock()
                AnyMakerEntryMock()
                AnyMakerEntryMock()
                AnyMakerEntryMock()
            }
            expect(tree.includeEntries.count) == 2
            expect(tree.makerEntries.count) == 3
        }
    }
} }

// TODO: Return SwinjectTree directly from builder once full support for @functionBuilder is available
func makeTree(@SwinjectTreeBuilder builder: () -> [SwinjectEntry]) -> SwinjectTree {
    SwinjectTreeBuilder.buildFunction(builder())
}

func makeTree(@SwinjectTreeBuilder builder: () -> SwinjectEntry) -> SwinjectTree {
    SwinjectTreeBuilder.buildFunction([builder()])
}

func makeTree(@SwinjectTreeBuilder _: () -> Void) -> SwinjectTree {
    SwinjectTreeBuilder.buildFunction([])
}
