//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class StandardScopeRegistrySpec: QuickSpec { override func spec() {
    var registry: StandardScopeRegistry!
    let person = (1 ... 3).map { _ in Person() }
    let key = (1 ... 3).map { ScopeRegistryKey(descriptor: plain(Int.self), argument: AnyMatchable($0)) }
    beforeEach {
        registry = StandardScopeRegistry()
    }
} }
