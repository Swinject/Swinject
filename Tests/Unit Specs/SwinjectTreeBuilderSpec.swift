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
            let tree = makeTree { register().constant(42) }
            expect(tree.bindings.count) == 1
        }
        it("builds closure with multiple entries") {
            let tree = makeTree {
                register().constant(42 as Int)
                register().constant(42 as UInt)
                register().constant(42 as Float)
                register().constant(42 as Double)
                register().constant(42 as Int32)
            }
            expect(tree.bindings.count) == 5
        }
        it("builds closure with if statement") {
            let tree = makeTree {
                if true { register().constant(42) }
            }
            expect(tree.bindings.count) == 1
        }
        it("builds closure with nested if statement") {
            let tree = makeTree {
                if true {
                    register().constant(42)
                    if true { register().constant(42 as UInt) }
                }
            }
            expect(tree.bindings.count) == 2
        }
        it("builds closure with if else statement") {
            let tree = makeTree {
                if false {} else {
                    register().constant(42)
                    register().constant(42 as UInt)
                }
            }
            expect(tree.bindings.count) == 2
        }
        it("builds closure with maker & include entries") {
            let tree = makeTree {
                include(Swinject.Module("1"))
                include(Swinject.Module("2"))
                register().constant(42)
                register().constant(42 as UInt)
                register().constant(42 as Float)
            }
            expect(tree.modules.count) == 2
            expect(tree.bindings.count) == 3
        }
        it("builds closure with translator entries") {
            let tree = makeTree {
                registerContextTranslator(from: Int.self) { Double($0) }
                registerContextTranslator(from: Float.self) { Double($0) }
                registerContextTranslator(from: UInt.self) { Double($0) }
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
