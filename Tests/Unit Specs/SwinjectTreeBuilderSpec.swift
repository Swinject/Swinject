//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class SwinjectTreeBuilderSpec: QuickSpec { override func spec() { #if swift(>=5.1)
    describe("allowed syntax") {
        it("builds empty closure") {
            let tree = makeTree {}
            expect(tree.bindings).to(beEmpty())
        }
        it("builds closure with single entry") {
            let tree = makeTree { BindingMock() }
            expect(tree.bindings.count) == 1
        }
        it("builds closure with multiple entries") {
            let tree = makeTree {
                BindingMock(); BindingMock(); BindingMock(); BindingMock(); BindingMock()
            }
            expect(tree.bindings.count) == 5
        }
        // FIXME: Test coverage enabled build segfaults on this
//        it("builds closure with if statement") {
//            let tree = makeTree {
//                if true { BindingMock() }
//            }
//            expect(tree.bindings.count) == 1
//        }
//        it("builds closure with nested if statement") {
//            let tree = makeTree {
//                if true { BindingMock(); if true { BindingMock() } }
//            }
//            expect(tree.bindings.count) == 2
//        }
//        it("builds closure with if else statement") {
//            let tree = makeTree {
//                if false {} else { BindingMock(); BindingMock() }
//            }
//            expect(tree.bindings.count) == 2
//        }
        it("builds closure with maker & include entries") {
            let tree = makeTree {
                Swinject.Module("1")
                Swinject.Module("2")
                BindingMock()
                BindingMock()
                BindingMock()
            }
            expect(tree.modules.count) == 2
            expect(tree.bindings.count) == 3
        }
        it("builds closure with translator entries") {
            let tree = makeTree {
                AnyContextTranslatorMock()
                AnyContextTranslatorMock()
                AnyContextTranslatorMock()
            }
            expect(tree.translators.count) == 3
        }
    }
    #endif
} }

#if swift(>=5.1)
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
#endif
