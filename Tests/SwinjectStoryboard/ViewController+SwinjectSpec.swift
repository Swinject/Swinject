//
//  ViewController+SwinjectSpec.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 8/1/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//


import Quick
import Nimble
@testable import Swinject
    
#if os(iOS) || os(tvOS)
private let createViewController = { UIViewController(nibName: nil, bundle: nil) }
#elseif os(OSX)
private let createViewController = { NSViewController(nibName: nil, bundle: nil)! }
#endif

#if os(iOS) || os(OSX) || os(tvOS)

class ViewController_SwinjectSpec: QuickSpec {
    override func spec() {
        it("adds a property to UIViewController to store Swinject container registration name.") {
            let viewController1 = createViewController()
            let viewController2 = createViewController()
            viewController1.swinjectRegistrationName = "1"
            viewController2.swinjectRegistrationName = "2"
            
            expect(viewController1.swinjectRegistrationName) == "1"
            expect(viewController2.swinjectRegistrationName) == "2"
        }
    }
}

#endif
