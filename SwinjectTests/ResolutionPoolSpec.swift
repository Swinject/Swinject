//
//  ResolutionPoolSpec.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/29/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Quick
import Nimble
@testable import Swinject

class ResolutionPoolSpec: QuickSpec {
    override func spec() {
        it("clears the pool when its depth gets zero.") {
            let key = ServiceKey(factoryType: Any.self)
            var resolutionPool = ResolutionPool()
            resolutionPool.incrementDepth()
            resolutionPool[key] = 0
            
            resolutionPool.incrementDepth()
            expect(resolutionPool[key]).notTo(beNil())
            resolutionPool.decrementDepth()
            expect(resolutionPool[key]).notTo(beNil())
            resolutionPool.decrementDepth()
            expect(resolutionPool[key]).to(beNil())
        }
    }
}
