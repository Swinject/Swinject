//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
import Swinject

class SwinjectSpec: QuickSpec { override func spec() {
    describe("injection") {
        context("no bindings") {
            it("throws") {
                let swinject = Swinject {}
                expect { try swinject.instance(of: Int.self) }.to(throwError())
            }
        }
        context("single binding") {
            var swinject: Swinject!
            var binding = AnyBindingMock()
            var descriptor = AnyTypeDescriptorMock()
            beforeEach {
                binding = AnyBindingMock()
                descriptor = AnyTypeDescriptorMock()
                swinject = Swinject { bbind(descriptor) & binding }
            }
            it("request instance from matching binding") {
                descriptor.matchesReturnValue = true
                _ = try? swinject.instance(of: Any.self)
                expect(binding.instanceUsingCallsCount) == 1
            }
            it("does not request instance from matching binding until instance is required") {
                descriptor.matchesReturnValue = true
                expect(binding.instanceUsingCallsCount) == 0
            }
            it("only requests instance from matching binding") {
                descriptor.matchesReturnValue = false
                _ = try? swinject.instance(of: Any.self)
                expect(binding.instanceUsingCallsCount) == 0
            }
            it("returns instance produced by binding") {
                descriptor.matchesReturnValue = true
                binding.instanceUsingReturnValue = 42
                expect { try swinject.instance(of: Any.self) as? Int } == 42
            }
            it("rethrows error from binding") {
                descriptor.matchesReturnValue = true
                binding.instanceUsingThrowableError = TestError()
                expect { try swinject.instance(of: Any.self) }.to(throwError(errorType: TestError.self))
            }
            it("throws if bound type does not match requested type") {
                descriptor.matchesReturnValue = true
                binding.instanceUsingReturnValue = ""
                expect { try swinject.instance(of: Double.self) }.to(throwError())
            }
            it("does not throw if bound type conforms to the requested type") {
                descriptor.matchesReturnValue = true
                binding.instanceUsingReturnValue = 42
                expect { try swinject.instance(of: CustomStringConvertible?.self) }.notTo(throwError())
            }
        }
    }
} }
