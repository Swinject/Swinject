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
        var container: Container!
        beforeEach {
            container = Container()
        }
        
        describe("Resolution of the same service") {
            it("resolves by arguments.") {
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
            it("resolves by the registered name.") {
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
            let registerCatAndPetOwnerDependingOnHouse: Container -> Void = {
                $0.register(AnimalType.self) {
                    let cat = Cat()
                    cat.house = $0.resolve(HouseType.self)
                    return cat
                }
                $0.register(PersonType.self) {
                    let owner = PetOwner(pet: $0.resolve(AnimalType.self)!)
                    owner.house = $0.resolve(HouseType.self)
                    return owner
                }
            }
            
            context("in no scope") {
                it("does not have a shared object in a container.") {
                    container.register(AnimalType.self) { _ in Cat() }
                        .inObjectScope(.None)
                    
                    let cat1 = container.resolve(AnimalType.self) as! Cat
                    let cat2 = container.resolve(AnimalType.self) as! Cat
                    expect(cat1) !== cat2
                }
                it("resolves a service to new objects in a graph") {
                    registerCatAndPetOwnerDependingOnHouse(container)
                    container.register(HouseType.self) { _ in Apartment() }
                        .inObjectScope(.None)
                    
                    let owner = container.resolve(PersonType.self) as! PetOwner
                    let ownerApartment = owner.house as! Apartment
                    let catApartment = (owner.pet as! Cat).house as! Apartment
                    expect(ownerApartment) !== catApartment
                }
            }
            context("in graph scope") {
                it("does not have a shared object in a container.") {
                    container.register(AnimalType.self) { _ in Cat() }
                        .inObjectScope(.Graph)
                    
                    let cat1 = container.resolve(AnimalType.self) as! Cat
                    let cat2 = container.resolve(AnimalType.self) as! Cat
                    expect(cat1) !== cat2
                }
                it("resolves a service to the same object in a graph") {
                    registerCatAndPetOwnerDependingOnHouse(container)
                    container.register(HouseType.self) { _ in Apartment() }
                        .inObjectScope(.Graph)
                    
                    let owner = container.resolve(PersonType.self) as! PetOwner
                    let ownerApartment = owner.house as! Apartment
                    let catApartment = (owner.pet as! Cat).house as! Apartment
                    expect(ownerApartment) === catApartment
                }
            }
            context("in container scope") {
                it("shares an object in the own container.") {
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
                    parent.register(AnimalType.self, name: "dog") { _ in Dog() }
                        .inObjectScope(.Container)
                    let child = Container(parent: parent)
                    
                    // Case resolving on the parent first.
                    let cat1 = parent.resolve(AnimalType.self) as! Cat
                    let cat2 = child.resolve(AnimalType.self) as! Cat
                    expect(cat1) !== cat2
                    
                    // Case resolving on the child first.
                    let dog1 = child.resolve(AnimalType.self, name: "dog") as! Dog
                    let dog2 = parent.resolve(AnimalType.self, name: "dog") as! Dog
                    expect(dog1) !== dog2
                }
                it("resolves a service to the same object in a graph") {
                    registerCatAndPetOwnerDependingOnHouse(container)
                    container.register(HouseType.self) { _ in Apartment() }
                        .inObjectScope(.Container)
                    
                    let owner = container.resolve(PersonType.self) as! PetOwner
                    let ownerApartment = owner.house as! Apartment
                    let catApartment = (owner.pet as! Cat).house as! Apartment
                    expect(ownerApartment) === catApartment
                }
            }
            context("in hierarchy scope") {
                it("shares an object in the own container.") {
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
                    parent.register(AnimalType.self, name: "dog") { _ in Dog() }
                        .inObjectScope(.Hierarchy)
                    let child = Container(parent: parent)
                    
                    // Case resolving on the parent first.
                    let cat1 = parent.resolve(AnimalType.self) as! Cat
                    let cat2 = child.resolve(AnimalType.self) as! Cat
                    expect(cat1) === cat2
                    
                    // Case resolving on the child first.
                    let dog1 = child.resolve(AnimalType.self, name: "dog") as! Dog
                    let dog2 = parent.resolve(AnimalType.self, name: "dog") as! Dog
                    expect(dog1) === dog2
                }
                it("resolves a service in the parent container to the same object in a graph") {
                    let parent = Container()
                    parent.register(HouseType.self) { _ in Apartment() }
                        .inObjectScope(.Hierarchy)
                    let child = Container(parent: parent)
                    registerCatAndPetOwnerDependingOnHouse(child)
                    
                    let owner = child.resolve(PersonType.self) as! PetOwner
                    let ownerApartment = owner.house as! Apartment
                    let catApartment = (owner.pet as! Cat).house as! Apartment
                    expect(ownerApartment) === catApartment
                }
            }
        }
        describe("Init completed event") {
            it("raises the event when a new instance is created.") {
                var eventRaised = false
                container.register(AnimalType.self) { _ in Cat() }
                    .initCompleted { (_, _) in eventRaised = true }
                
                let cat = container.resolve(AnimalType.self)
                expect(cat).notTo(beNil())
                expect(eventRaised) == true
            }
        }
        describe("Injection types") {
            it("accepts initializer injection.") {
                container.register(AnimalType.self) { _ in Cat() }
                container.register(PersonType.self) { c in PetOwner(pet: c.resolve(AnimalType.self)!) }
                
                let owner = container.resolve(PersonType.self) as! PetOwner
                expect(owner.pet).notTo(beNil())
            }
            it("accepts property injection in registration.") {
                container.register(AnimalType.self) { _ in Cat() }
                container.register(PersonType.self) { c in
                    let owner = PetOwner()
                    owner.pet = c.resolve(AnimalType.self)!
                    return owner
                }
                
                let owner = container.resolve(PersonType.self) as! PetOwner
                expect(owner.pet).notTo(beNil())
            }
            it("accepts property injection in initCompleted event.") {
                container.register(AnimalType.self) { _ in Cat() }
                container.register(PersonType.self) { c in PetOwner() }
                    .initCompleted { (c, p) in
                        let owner = p as! PetOwner
                        owner.pet = c.resolve(AnimalType.self)!
                    }
                
                let owner = container.resolve(PersonType.self) as! PetOwner
                expect(owner.pet).notTo(beNil())
            }
            it("accepts method injection in registration.") {
                container.register(AnimalType.self) { _ in Cat() }
                container.register(PersonType.self) { c in
                    let owner = PetOwner()
                    owner.injectAnimal(c.resolve(AnimalType.self)!)
                    return owner
                }
                
                let owner = container.resolve(PersonType.self) as! PetOwner
                expect(owner.pet).notTo(beNil())
            }
            it("accepts method injection in initCompleted event.") {
                container.register(AnimalType.self) { _ in Cat() }
                container.register(PersonType.self) { c in PetOwner() }
                    .initCompleted { (c, p) in
                        let owner = p as! PetOwner
                        owner.injectAnimal(c.resolve(AnimalType.self)!)
                    }
                
                let owner = container.resolve(PersonType.self) as! PetOwner
                expect(owner.pet).notTo(beNil())
            }
        }
    }
}
