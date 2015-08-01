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
        }
    }
}
