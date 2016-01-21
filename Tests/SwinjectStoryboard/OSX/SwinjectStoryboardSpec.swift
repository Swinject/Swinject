//
//  SwinjectStoryboardSpec.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 8/1/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Quick
import Nimble
@testable import Swinject

private var swinjectStoryboardSetupCount = 0
extension SwinjectStoryboard {
    static func setup() {
        swinjectStoryboardSetupCount++
    }
}

class SwinjectStoryboardSpec: QuickSpec {
    override func spec() {
        let bundle = NSBundle(forClass: SwinjectStoryboardSpec.self)
        var container: Container!
        beforeEach {
            container = Container()
        }
        
        describe("Instantiation from storyboard") {
            it("injects view controller dependency definded by initCompleted handler.") {
                container.registerForStoryboard(AnimalViewController.self) { r, c in
                    c.animal = r.resolve(AnimalType.self)
                }
                container.register(AnimalType.self) { _ in Cat(name: "Mimi") }
                
                let storyboard = SwinjectStoryboard.create(name: "Animals", bundle: bundle, container: container)
                let animalViewController = storyboard.instantiateControllerWithIdentifier("AnimalView") as! AnimalViewController
                expect(animalViewController.hasAnimal(named: "Mimi")) == true
            }
            it("injects window controller dependency definded by initCompleted handler.") {
                container.registerForStoryboard(AnimalWindowController.self) { r, c in
                    c.animal = r.resolve(AnimalType.self)
                }
                container.register(AnimalType.self) { _ in Cat(name: "Mew") }
                
                let storyboard = SwinjectStoryboard.create(name: "Animals", bundle: bundle, container: container)
                let animalViewController = storyboard.instantiateControllerWithIdentifier("AnimalWindow") as! AnimalWindowController
                expect(animalViewController.hasAnimal(named: "Mew")) == true
            }
            it("injects dependency to child view controllers.") {
                container.registerForStoryboard(AnimalViewController.self) { r, c in
                    c.animal = r.resolve(AnimalType.self)
                }
                container.register(AnimalType.self) { _ in Cat() }
                    .inObjectScope(.Container)
                
                let storyboard = SwinjectStoryboard.create(name: "Tabs", bundle: bundle, container: container)
                let tabBarController = storyboard.instantiateControllerWithIdentifier("TabBarController")
                let animalViewController1 = tabBarController.childViewControllers[0] as! AnimalViewController
                let animalViewController2 = tabBarController.childViewControllers[1] as! AnimalViewController
                let cat1 = animalViewController1.animal as! Cat
                let cat2 = animalViewController2.animal as! Cat
                expect(cat1) === cat2
            }
            context("with a registration name set as a user defined runtime attribute on Interface Builder") {
                it("injects view controller dependency definded by initCompleted handler with the registration name.") {
                    // The registration name "hachi" is set in the storyboard.
                    container.registerForStoryboard(AnimalViewController.self, name: "hachi") { r, c in
                        c.animal = r.resolve(AnimalType.self)
                    }
                    container.register(AnimalType.self) { _ in Dog(name: "Hachi") }
                    
                    // This registration should not be resolved.
                    container.registerForStoryboard(AnimalViewController.self) { _, c in
                        c.animal = Cat(name: "Mimi")
                    }
                    
                    let storyboard = SwinjectStoryboard.create(name: "Animals", bundle: bundle, container: container)
                    let animalViewController = storyboard.instantiateControllerWithIdentifier("HachiView") as! AnimalViewController
                    expect(animalViewController.hasAnimal(named: "Hachi")) == true
                }
                it("injects window controller dependency definded by initCompleted handler with the registration name.") {
                    // The registration name "hachi" is set in the storyboard.
                    container.registerForStoryboard(AnimalWindowController.self, name: "pochi") { r, c in
                        c.animal = r.resolve(AnimalType.self)
                    }
                    container.register(AnimalType.self) { _ in Dog(name: "Pochi") }
                    
                    // This registration should not be resolved.
                    container.registerForStoryboard(AnimalWindowController.self) { _, c in
                        c.animal = Cat(name: "Mimi")
                    }
                    
                    let storyboard = SwinjectStoryboard.create(name: "Animals", bundle: bundle, container: container)
                    let animalViewController = storyboard.instantiateControllerWithIdentifier("PochiWindow") as! AnimalWindowController
                    expect(animalViewController.hasAnimal(named: "Pochi")) == true
                }
            }
            context("with container hierarchy") {
                it("injects view controller dependency definded in the parent container.") {
                    container.registerForStoryboard(AnimalViewController.self) { r, c in
                        c.animal = r.resolve(AnimalType.self)
                    }
                    container.register(AnimalType.self) { _ in Cat(name: "Mimi") }
                    let childContainer = Container(parent: container)
                    
                    let storyboard = SwinjectStoryboard.create(name: "Animals", bundle: bundle, container: childContainer)
                    let animalViewController = storyboard.instantiateControllerWithIdentifier("AnimalView") as! AnimalViewController
                    expect(animalViewController.hasAnimal(named: "Mimi")) == true
                }
            }
        }
        describe("Initial controller") {
            it("injects dependency definded by initCompleted handler.") {
                container.registerForStoryboard(AnimalWindowController.self) { r, c in
                    c.animal = r.resolve(AnimalType.self)
                }
                container.register(AnimalType.self) { _ in Cat(name: "Mew") }
                
                let storyboard = SwinjectStoryboard.create(name: "Animals", bundle: bundle, container: container)
                let animalViewController = storyboard.instantiateInitialController() as! AnimalWindowController
                expect(animalViewController.hasAnimal(named: "Mew")) == true
            }
        }
        describe("Factory method") {
            it("uses the default shared container if no container is passed.") {
                SwinjectStoryboard.defaultContainer.registerForStoryboard(AnimalViewController.self) { _, _ in }
                
                let storyboard = SwinjectStoryboard.create(name: "Animals", bundle: bundle)
                let animalViewController = storyboard.instantiateControllerWithIdentifier("AnimalView")
                expect(animalViewController).notTo(beNil())
            }
            
            afterEach {
                SwinjectStoryboard.defaultContainer.removeAll()
            }
        }
        describe("Storyboard reference") {
            it("inject dependency to the view controller in the referenced storyboard.") {
                SwinjectStoryboard.defaultContainer.registerForStoryboard(AnimalViewController.self) { r, c in
                    c.animal = r.resolve(AnimalType.self)
                }
                SwinjectStoryboard.defaultContainer.register(AnimalType.self) { _ in Cat(name: "Mimi") }
                
                let storyboard1 = SwinjectStoryboard.create(name: "Storyboard1", bundle: bundle)
                let windowController = storyboard1.instantiateInitialController() as! NSWindowController
                let viewController1 = windowController.contentViewController as! ViewController1
                viewController1.performSegueWithIdentifier("ToStoryboard2", sender: nil)
                expect(viewController1.animalViewController?.hasAnimal(named: "Mimi")).toEventually(beTrue())
            }
            
            afterEach {
                SwinjectStoryboard.defaultContainer.removeAll()
            }
        }
        describe("Setup") {
            it("calls setup function only once.") {
                _ = SwinjectStoryboard.create(name: "Animals", bundle: bundle)
                _ = SwinjectStoryboard.create(name: "Animals", bundle: bundle)
                expect(swinjectStoryboardSetupCount) == 1
            }
        }
    }
}
