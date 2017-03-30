//
//  AssemblerSpec.swift
//  Swinject
//
//  Created by mike.owens on 12/9/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Swinject

class AssemblerSpec: QuickSpec {
    override func spec() {
        
        describe("Assembler basic init") {
            it("can assembly a single container") {
                let assembler = Assembler([
                    AnimalAssembly()
                ])
                let cat = assembler.resolver.resolve(Animal.self)
                expect(cat).toNot(beNil())
                expect(cat!.name) == "Whiskers"
                
                let sushi = assembler.resolver.resolve(Food.self)
                expect(sushi).to(beNil())
            }
            
            it("can assembly a container with nil parent") {
                let assembler = Assembler(parentAssembler: nil)
                
                let sushi = assembler.resolver.resolve(Food.self)
                expect(sushi).to(beNil())
            }
            
            it("can assembly a container with nil parent and assemblies") {
                let assembler = Assembler([
                    AnimalAssembly()
                ], parent: nil)
                let cat = assembler.resolver.resolve(Animal.self)
                expect(cat).toNot(beNil())
                expect(cat!.name) == "Whiskers"
                
                let sushi = assembler.resolver.resolve(Food.self)
                expect(sushi).to(beNil())
            }
            
            it("can assembly a multiple container") {
                let assembler = Assembler([
                    AnimalAssembly(),
                    FoodAssembly()
                ])
                let cat = assembler.resolver.resolve(Animal.self)
                expect(cat).toNot(beNil())
                expect(cat!.name) == "Whiskers"
                
                let sushi = assembler.resolver.resolve(Food.self)
                expect(sushi).toNot(beNil())
                expect(sushi is Sushi) == true
            }
            
            it("can assembly a multiple container with inter dependencies") {
                let assembler = Assembler([
                    AnimalAssembly(),
                    FoodAssembly(),
                    PersonAssembly()
                ])
                let petOwner = assembler.resolver.resolve(PetOwner.self)
                expect(petOwner).toNot(beNil())
                
                let cat = petOwner!.pet
                expect(cat).toNot(beNil())
                expect(cat!.name) == "Whiskers"
                
                let sushi = petOwner!.favoriteFood
                expect(sushi).toNot(beNil())
                expect(sushi is Sushi) == true
            }
            
            it("can assembly a multiple container with inter dependencies in any order") {
                let assembler = Assembler([
                    PersonAssembly(),
                    AnimalAssembly(),
                    FoodAssembly(),
                ])
                let petOwner = assembler.resolver.resolve(PetOwner.self)
                expect(petOwner).toNot(beNil())
                
                let cat = petOwner!.pet
                expect(cat).toNot(beNil())
                expect(cat!.name) == "Whiskers"
                
                let sushi = petOwner!.favoriteFood
                expect(sushi).toNot(beNil())
                expect(sushi is Sushi) == true
            }
        }
        
        describe("Assembler lazy build") {
            it("can assembly a single container") {
                let assembler = Assembler([])
                var cat = assembler.resolver.resolve(Animal.self)
                expect(cat).to(beNil())
                
                assembler.apply(assembly: AnimalAssembly())
                
                cat = assembler.resolver.resolve(Animal.self)
                expect(cat).toNot(beNil())
                expect(cat!.name) == "Whiskers"
            }
            
            it("can assembly a single load aware container") {
                let assembler = Assembler([])
                var cat = assembler.resolver.resolve(Animal.self)
                expect(cat).to(beNil())
                
                let loadAwareAssembly = LoadAwareAssembly() { resolver in
                    let cat = resolver.resolve(Animal.self)
                    expect(cat).toNot(beNil())
                    expect(cat!.name) == "Bojangles"
                }
                
                expect(loadAwareAssembly.loaded) == false
                assembler.apply(assembly: loadAwareAssembly)
                expect(loadAwareAssembly.loaded) == true
                
                cat = assembler.resolver.resolve(Animal.self)
                expect(cat).toNot(beNil())
                expect(cat!.name) == "Bojangles"
            }
            
            it("can assembly a multiple containers 1 by 1") {
                let assembler = Assembler([])
                var cat = assembler.resolver.resolve(Animal.self)
                expect(cat).to(beNil())
                
                var sushi = assembler.resolver.resolve(Food.self)
                expect(sushi).to(beNil())
                
                assembler.apply(assembly: AnimalAssembly())
                
                cat = assembler.resolver.resolve(Animal.self)
                expect(cat).toNot(beNil())
                expect(cat!.name) == "Whiskers"
                
                sushi = assembler.resolver.resolve(Food.self)
                expect(sushi).to(beNil())
                
                assembler.apply(assembly: FoodAssembly())
                
                sushi = assembler.resolver.resolve(Food.self)
                expect(sushi).toNot(beNil())
            }
            
            it("can assembly a multiple containers at once") {
                let assembler = Assembler([])
                var cat = assembler.resolver.resolve(Animal.self)
                expect(cat).to(beNil())
                
                var sushi = assembler.resolver.resolve(Food.self)
                expect(sushi).to(beNil())
                
                assembler.apply(assemblies: [
                    AnimalAssembly(),
                    FoodAssembly()
                ])
                
                cat = assembler.resolver.resolve(Animal.self)
                expect(cat).toNot(beNil())
                expect(cat!.name) == "Whiskers"
                
                sushi = assembler.resolver.resolve(Food.self)
                expect(sushi).toNot(beNil())
            }
        }
        
        describe("Assembler load aware") {
            it("can assembly a single container") {
                let loadAwareAssembly = LoadAwareAssembly() { resolver in
                    let cat = resolver.resolve(Animal.self)
                    expect(cat).toNot(beNil())
                    expect(cat!.name) == "Bojangles"
                }
                
                expect(loadAwareAssembly.loaded) == false
                let assembler = Assembler([
                    loadAwareAssembly
                ])
                expect(loadAwareAssembly.loaded) == true

                let cat = assembler.resolver.resolve(Animal.self)
                expect(cat).toNot(beNil())
                expect(cat!.name) == "Bojangles"
            }
            
            it("can assembly a multiple container") {
                let loadAwareAssembly = LoadAwareAssembly() { resolver in
                    let cat = resolver.resolve(Animal.self)
                    expect(cat).toNot(beNil())
                    expect(cat!.name) == "Bojangles"
                    
                    let sushi = resolver.resolve(Food.self)
                    expect(sushi).toNot(beNil())
                }
                
                expect(loadAwareAssembly.loaded) == false
                let assembler = Assembler([
                    loadAwareAssembly,
                    FoodAssembly()
                ])
                expect(loadAwareAssembly.loaded) == true
                
                let cat = assembler.resolver.resolve(Animal.self)
                expect(cat).toNot(beNil())
                expect(cat!.name) == "Bojangles"
                
                let sushi = assembler.resolver.resolve(Food.self)
                expect(sushi).toNot(beNil())
            }
        }
        
        describe("Empty Assembler") {
            it("can create an empty assembler and build it") {
                let assembler = Assembler()
                
                var cat = assembler.resolver.resolve(Animal.self)
                expect(cat).to(beNil())
                
                assembler.apply(assembly: AnimalAssembly())
                
                cat = assembler.resolver.resolve(Animal.self)
                expect(cat).toNot(beNil())
                expect(cat!.name) == "Whiskers"
            }
        }
        
        describe("Child Assembler") {
            it("can be empty") {
                let assembler = Assembler([
                    AnimalAssembly()
                ])
                
                let childAssembler = Assembler(parentAssembler: assembler)
                
                let cat = assembler.resolver.resolve(Animal.self)
                expect(cat).toNot(beNil())
                
                let sushi = assembler.resolver.resolve(Food.self)
                expect(sushi).to(beNil())
                
                let childCat = childAssembler.resolver.resolve(Animal.self)
                expect(childCat).toNot(beNil())
                
                let childSushi = childAssembler.resolver.resolve(Food.self)
                expect(childSushi).to(beNil())
            }
            
            it("can't give entities to parent") {
                let assembler = Assembler()
                let childAssembler = Assembler([
                    AnimalAssembly()
                ], parent: assembler)
                
                let cat = assembler.resolver.resolve(Animal.self)
                expect(cat).to(beNil())
                
                let childCat = childAssembler.resolver.resolve(Animal.self)
                expect(childCat).toNot(beNil())
            }
        }
    }
}
