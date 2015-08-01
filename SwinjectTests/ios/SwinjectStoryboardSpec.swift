//
//  SwinjectStoryboardSpec.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/31/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Quick
import Nimble
@testable import Swinject

class SwinjectStoryboardSpec: QuickSpec {
    override func spec() {
        var container: Container!
        var storyboard: SwinjectStoryboard!
        beforeEach {
            container = Container()
            let bundle = NSBundle(forClass: SwinjectStoryboardSpec.self)
            storyboard = SwinjectStoryboard.create(name: "TestStoryboard", bundle: bundle, container: container)
        }
        
        describe("Instantiation from storyboard") {
            it("injects dependency definded by initCompleted handler.") {
                container.registerForStoryboard(AnimalViewController.self) { r, vc in
                    vc.animal = r.resolve(AnimalType.self)
                }
                container.register(AnimalType.self) { _ in Cat(name: "Mimi") }
                
                let animalViewController = storyboard.instantiateViewControllerWithIdentifier("AnimalAsCat") as! AnimalViewController
                expect(animalViewController.hasAnimal(named: "Mimi")) == true
            }
            context("with a registration name set as a user defined runtime attribute on Interface Builder") {
                it("injects dependency definded by initCompleted handler with the registration name.") {
                    // The registration name "hachi" is set in the storyboard.
                    container.registerForStoryboard(AnimalViewController.self, name: "hachi") { r, vc in
                        vc.animal = r.resolve(AnimalType.self)
                    }
                    container.register(AnimalType.self) { _ in Dog(name: "Hachi") }
                    
                    // This registration should not be resolved.
                    container.registerForStoryboard(AnimalViewController.self) { _, vc in
                        vc.animal = Cat(name: "Mimi")
                    }
                    
                    let animalViewController = storyboard.instantiateViewControllerWithIdentifier("AnimalAsDog") as! AnimalViewController
                    expect(animalViewController.hasAnimal(named: "Hachi")) == true
                }
            }
        }
    }
}
