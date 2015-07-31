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
        it("instantiates a view controller with an identifier.") {
            let bundle = NSBundle(forClass: SwinjectStoryboardSpec.self)
            let storyboard = SwinjectStoryboard.create(name: "TestStoryboard", bundle: bundle)
            let viewController = storyboard.instantiateViewControllerWithIdentifier("TabBarController")
            expect(viewController).to(beAnInstanceOf(UITabBarController.self))
        }
    }
}
