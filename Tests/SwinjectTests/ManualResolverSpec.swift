//
//  ManualResolverSpec.swift
//  Swinject
//
//  Created by Brian Radebaugh on 8/12/18.
//  Copyright © 2018 Swinject Contributors. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Swinject

class MyAssembly: Assembly {
    func assemble(container: Container) {
        container.register(Food.self) { _ in
            return Sushi()
        }

        container.registerManualConstruction(BasicViewController.self) { (resolver, basicViewController) in
            let food = resolver.resolve(Food.self)!

            basicViewController.inject(food: food)
        }
    }
}

class ManualResolverSpec: QuickSpec {
    override func spec() {

        describe("ManualResolver") {
            let assembler: Assembler = Assembler([MyAssembly()], container: ManualResolver.container)

            it("should resolve manually registered ") {
                let basicViewController = assembler.resolver.resolve(BasicViewController.self)
                expect(basicViewController).toNot(beNil())
            }
        }
    }
}
