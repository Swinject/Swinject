//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class SimpleBindingSpec: QuickSpec { override func spec() {
    describe("binding builder") {
        let builder = SimpleBinding.Builder<Void, String, Int> { _, _, _ in }
        it("makes binding with self as maker") {
            let binding = builder.makeBinding(for: AnyTypeDescriptorMock()) as? SimpleBinding
            expect(binding?.maker is SimpleBinding.Builder<Void, String, Int>).to(beTrue())
        }
        it("makes binding with correct key") {
            let descriptor = AnyTypeDescriptorMock()
            let binding = builder.makeBinding(for: descriptor) as? SimpleBinding
            expect(binding?.key.descriptor) === descriptor
            expect(binding?.key.contextType is String.Type).to(beTrue())
            expect(binding?.key.argumentType is Int.Type).to(beTrue())
        }
    }
} }
