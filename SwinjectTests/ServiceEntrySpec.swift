//
//  ServiceEntrySpec.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/29/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Quick
import Nimble
@testable import Swinject

class ServiceEntrySpec: QuickSpec {
    override func spec() {
        it("has ObjectScope.Graph as a default value of scope property.") {
            let entry = ServiceEntryBase(factory: 0)
            expect(entry.scope) == ObjectScope.Graph
        }
    }
}
