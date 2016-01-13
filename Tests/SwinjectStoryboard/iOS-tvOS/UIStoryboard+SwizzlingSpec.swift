//
//  UIStoryboard+SwizzlingSpec.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 10/10/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Quick
import Nimble
@testable import Swinject

class UIStoryboard_SwizzlingSpec: QuickSpec {
    override func spec() {
        let bundle = NSBundle(forClass: UIViewController_SwinjectSpec.self)

        it("instantiates SwinjectStoryboard when UIStoryboard is tried to be instantiated.") {
            let storyboard = UIStoryboard(name: "Animals", bundle: bundle)
            expect(storyboard).to(beAnInstanceOf(SwinjectStoryboard.self))
        }
        it("does not have infinite calls of swizzled methods to explicitly instantiate SwinjectStoryboard.") {
            let storyboard = SwinjectStoryboard.create(name: "Animals", bundle: bundle)
            expect(storyboard).notTo(beNil())
        }
    }
}
