//
//  Storyboard+SwizzlingSpec.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 10/10/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//


import Quick
import Nimble
@testable import Swinject
    
#if os(iOS) || os(tvOS)
private typealias Storyboard = UIStoryboard
#elseif os(OSX)
private typealias Storyboard = NSStoryboard
#endif

#if os(iOS) || os(OSX) || os(tvOS)

class Storyboard_SwizzlingSpec: QuickSpec {
    override func spec() {
        let bundle = NSBundle(forClass: Storyboard_SwizzlingSpec.self)

        it("instantiates SwinjectStoryboard when UIStoryboard/NSStoryboard is tried to be instantiated.") {
            let storyboard = Storyboard(name: "Animals", bundle: bundle)
            expect(storyboard).to(beAnInstanceOf(SwinjectStoryboard.self))
        }
        it("does not have infinite calls of swizzled methods to explicitly instantiate SwinjectStoryboard.") {
            let storyboard = SwinjectStoryboard.create(name: "Animals", bundle: bundle)
            expect(storyboard).notTo(beNil())
        }
    }
}

#endif
