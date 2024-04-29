//
//  Copyright © 2024 Swinject Contributors. All rights reserved.
//

import XCTest
@testable import Swinject

/// Not a perfect way to measure speed improvements, especially with all the different hardware that will be running
/// this test, but good to run before/after changes to see changes.
@available(iOS 13.0, *)
class ContainerSpeedTests: XCTestCase {
    var container: Container!

    override func setUpWithError() throws {
        container = Container()

        container.register(Animal.self) { _ in Cat() }
        container.register(Animal.self) { _, arg in Cat(name: arg) }
        container.register(Animal.self) { _, arg1, arg2 in Cat(name: arg1, sleeping: arg2) }
    }

    // MARK: General speed test, ran locally for testing purposes

    func testContainerDefaultResolvesByArguments() {
        let measureOptions = XCTMeasureOptions()
        measureOptions.iterationCount = 1

        measure(options: measureOptions) {
            container.resolveCats()
        }
    }    

    func testContainerSyncResolvesByArguments() {
        container = container.synchronize() as? Container

        let measureOptions = XCTMeasureOptions()
        measureOptions.iterationCount = 1

        measure(options: measureOptions) {
            container.resolveCats()
        }
    }
}

fileprivate extension Container {
    func resolveCats() {
        for _ in 0..<500_000 {
            _ = resolve(Animal.self) as? Cat
            _ = resolve(Animal.self, argument: "Mimi") as? Cat
            let lazy = resolve(Lazy<Animal>.self, arguments: "Mew", true)
            _ = lazy?.instance as? Cat
        }
    }
}
