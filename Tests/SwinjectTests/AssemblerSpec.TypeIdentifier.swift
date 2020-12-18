//
//  AssemblerSpec.TypeIdentifier.swift
//  Swinject
//
//  Created by Benjamin Lavialle on 18/12/2020.
//

import Foundation
import Nimble
import Quick
@testable import Swinject

class AssemblerTypeIdentifierSpec: QuickSpec {
    override func spec() {
        describe("Assembler dedicated identifier init") {
            it("can identify with dedicated identifier in a container") {
                let assembler = Assembler([
                    AnimalTypeIdentifiedAssembly(),
                ])
                let cat = assembler.resolver.resolve(Animal.self, identifier: AnimalIdentifier.myCat)
                expect(cat).toNot(beNil())
                expect(cat!.name) == "Whiskers"
                let otherCat = assembler.resolver.resolve(Animal.self, identifier: AnimalIdentifier.myOtherCat)
                expect(otherCat).toNot(beNil())
                expect(otherCat!.name) == "Sylvester"
            }
        }

        describe("Assembler type identifier init") {
            it("can identify with type identifier in a container") {
                let assembler = Assembler([
                    CatTypeIdentifiedAssembly(),
                ])
                let cat = assembler.resolver.resolve(Cat.self, identifier: .firstCat)
                expect(cat).toNot(beNil())
                expect(cat!.name) == "Whiskers"
                let otherCat = assembler.resolver.resolve(Cat.self, identifier: .secondCat)
                expect(otherCat).toNot(beNil())
                expect(otherCat!.name) == "Sylvester"
            }
        }
    }
}
