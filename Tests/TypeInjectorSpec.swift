//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Quick
import Nimble
@testable import Swinject3

class TypeInjectorSpec: QuickSpec { override func spec() {
    it("calls injection method with given instance") {
        var passedInstance: Int?
        let it = injector(of: Int.self) { passedInstance = $0 }
        try? it.inject(42, using: FakeProvider())
        expect(passedInstance) == 42
    }
    it("calls injection method with given provider") {
        var passedProvider: Provider?
        let provider = FakeProvider()
        let it = injector(of: Int.self) { passedProvider = $1 }
        try? it.inject(0, using: provider)
        expect(passedProvider) === provider
    }
    it("rethrows injection method error") {
        let it = injector(of: Int.self) { _ in throw SwinjectError() }
        expect { try it.inject(0, using: FakeProvider()) }.to(throwError())
    }
}}

