//
//  UIViewController+SwinjectSpec.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 8/1/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Quick
import Nimble
@testable import Swinject

class UIViewController_SwinjectSpec: QuickSpec {
    override func spec() {
        it("adds a property to UIViewController to store Swinject container registration name.") {
            let viewController1 = UIViewController(nibName: nil, bundle: nil)
            let viewController2 = UIViewController(nibName: nil, bundle: nil)
            viewController1.swinjectRegistrationName = "1"
            viewController2.swinjectRegistrationName = "2"
            
            expect(viewController1.swinjectRegistrationName) == "1"
            expect(viewController2.swinjectRegistrationName) == "2"
        }
    }
}
