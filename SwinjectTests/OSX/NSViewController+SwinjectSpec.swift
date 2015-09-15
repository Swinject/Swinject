//
//  NSViewController+SwinjectSpec.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 8/1/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Quick
import Nimble
@testable import Swinject

class NSViewController_SwinjectSpec: QuickSpec {
    override func spec() {
        it("adds a property to NSViewController to store Swinject container registration name.") {
            let controller1 = NSViewController(nibName: nil, bundle: nil)!
            let controller2 = NSViewController(nibName: nil, bundle: nil)!
            controller1.swinjectRegistrationName = "1"
            controller2.swinjectRegistrationName = "2"
            
            expect(controller1.swinjectRegistrationName) == "1"
            expect(controller2.swinjectRegistrationName) == "2"
        }
    }
}
