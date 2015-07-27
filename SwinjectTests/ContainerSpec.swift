//
//  ContainerSpec.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/23/15.
//  Copyright © 2015 DevSwinject. All rights reserved.
//

import Quick
import Nimble
@testable import Swinject

class ContainerSpec: QuickSpec {
    override func spec() {
        describe("Basic resolution") {
            it("resolves a registreed instance.") {
                let container = Container()
                container.register(AnimalType.self) { _ in Cat() }
                
                let cat = container.resolve(AnimalType.self)
                expect(cat).notTo(beNil())
            }
            it("injects a resolved argument.") {
                let container = Container()
                container.register(AnimalType.self) { _ in Cat() }
                container.register(PersonType.self) { c in PetOwner(favoriteAnimal: c.resolve(AnimalType.self)!) }
                    
                let owner = container.resolve(PersonType.self) as! PetOwner
                expect(owner.favoriteAnimal).notTo(beNil())
            }
            it("resolves multiple initializers with arguments passed.") {
                let container = Container()
                container.register(AnimalType.self) { _ in Cat() }
                container.register(AnimalType.self) { container, arg in Cat(name: arg) }
                container.register(AnimalType.self) { container, arg1, arg2 in Cat(name: arg1, mature: arg2) }
                
                let noname = container.resolve(AnimalType.self) as! Cat
                let mimi = container.resolve(AnimalType.self, arg1: "Mimi") as! Cat
                let mew = container.resolve(AnimalType.self, arg1: "Mew", arg2: true) as! Cat
                expect(noname.name).to(beNil())
                expect(mimi.name) == "Mimi"
                expect(mew.name) == "Mew"
                expect(mew.mature) == true
            }
            it("resolves named services.") {
                let container = Container()
                container.register(AnimalType.self, name: "RegMimi") { _ in Cat(name: "Mimi") }
                container.register(AnimalType.self, name: "RegMew") { _ in Cat(name: "Mew") }
                container.register(AnimalType.self) { _ in Cat() }
                
                let mimi = container.resolve(AnimalType.self, name: "RegMimi") as! Cat
                let mew = container.resolve(AnimalType.self, name: "RegMew") as! Cat
                let noname = container.resolve(AnimalType.self) as! Cat
                expect(mimi.name) == "Mimi"
                expect(mew.name) == "Mew"
                expect(noname.name).to(beNil())
            }
        }
        describe("Container hierarchy") {
            it("resolves a service registered on the parent container.") {
                let parent = Container()
                parent.register(AnimalType.self) { _ in Cat() }
                let child = Container(parent: parent)
                
                let cat = child.resolve(AnimalType.self)
                expect(cat).notTo(beNil())
            }
            it("does not resolve a service registred on the child container.") {
                let parent = Container()
                let child = Container(parent: parent)
                child.register(AnimalType.self) { _ in Cat() }
                
                let cat = parent.resolve(AnimalType.self)
                expect(cat).to(beNil())
            }
        }
        describe("Scope") {
            context("in no scope") {
                it("does not have a shared object in a container.") {
                    let container = Container()
                    container.register(AnimalType.self) { _ in Cat() }
                    
                    let cat1 = container.resolve(AnimalType.self) as! Cat
                    let cat2 = container.resolve(AnimalType.self) as! Cat
                    expect(cat1) !== cat2
                }
            }
            context("in container scope") {
                it("shares an object in the own container.") {
                    let container = Container()
                    container.register(AnimalType.self) { _ in Cat() }
                        .inObjectScope(.Container)
                    
                    let cat1 = container.resolve(AnimalType.self) as! Cat
                    let cat2 = container.resolve(AnimalType.self) as! Cat
                    expect(cat1) === cat2
                }
                it("does not share an object from a parent container to its child.") {
                    let parent = Container()
                    parent.register(AnimalType.self) { _ in Cat() }
                        .inObjectScope(.Container)
                    parent.register(PersonType.self) { _ in PetOwner() }
                        .inObjectScope(.Container)
                    let child = Container(parent: parent)
                    
                    // Case resolving on the parent first.
                    let cat1 = parent.resolve(AnimalType.self) as! Cat
                    let cat2 = child.resolve(AnimalType.self) as! Cat
                    expect(cat1) !== cat2
                    
                    // Case resolving on the child first.
                    let owner1 = child.resolve(PersonType.self) as! PetOwner
                    let owner2 = parent.resolve(PersonType.self) as! PetOwner
                    expect(owner1) !== owner2
                }
            }
            context("in hierarchy scope") {
                it("shares an object in the own container.") {
                    let container = Container()
                    container.register(AnimalType.self) { _ in Cat() }
                        .inObjectScope(.Hierarchy)
                    
                    let cat1 = container.resolve(AnimalType.self) as! Cat
                    let cat2 = container.resolve(AnimalType.self) as! Cat
                    expect(cat1) === cat2
                }
                it("shares an object from a parent container to its child.") {
                    let parent = Container()
                    parent.register(AnimalType.self) { _ in Cat() }
                        .inObjectScope(.Hierarchy)
                    parent.register(PersonType.self) { _ in PetOwner() }
                        .inObjectScope(.Hierarchy)
                    let child = Container(parent: parent)
                    
                    // Case resolving on the parent first.
                    let cat1 = parent.resolve(AnimalType.self) as! Cat
                    let cat2 = child.resolve(AnimalType.self) as! Cat
                    expect(cat1) === cat2
                    
                    // Case resolving on the child first.
                    let owner1 = child.resolve(PersonType.self) as! PetOwner
                    let owner2 = parent.resolve(PersonType.self) as! PetOwner
                    expect(owner1) === owner2
                }
            }
        }
    }
}
