//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class SwinjectSpec: QuickSpec { override func spec() {
    describe("instance injection") {
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
            it("crashes if bound type does not match requested type") {
                descriptor.matchesReturnValue = true
                binding.instanceUsingReturnValue = ""
                expect { _ = try swinject.instance(of: Double.self) }.to(throwError())
            }
            it("does not crash if bound type conforms to the requested type") {
                descriptor.matchesReturnValue = true
                binding.instanceUsingReturnValue = 42
                expect { _ = try swinject.instance(of: CustomStringConvertible?.self) }.notTo(throwError())
            }
            it("passes swinject as injector") {
                descriptor.matchesReturnValue = true
                _ = try? swinject.instance(of: Any.self)
                expect(binding.instanceUsingReceivedInjector is Swinject).to(beTrue())
            }
        }
        context("multiple bindings") {
            var swinject: Swinject!
            var bindings = [AnyBindingMock]()
            var descriptors = [AnyTypeDescriptorMock]()
            beforeEach {
                descriptors = Array(0 ..< 3).map { _ in AnyTypeDescriptorMock() }
                descriptors.forEach { $0.matchesReturnValue = false }
                bindings = descriptors.map { _ in AnyBindingMock() }
                swinject = Swinject {
                    bbind(descriptors[0]) & bindings[0]
                    bbind(descriptors[1]) & bindings[1]
                    bbind(descriptors[2]) & bindings[2]
                }
            }
            it("throws if multiple entries match requested type") {
                descriptors.forEach { $0.matchesReturnValue = true }
                expect { try swinject.instance(of: Any.self) }.to(throwError())
            }
            it("does not throw if single entry matches requested type") {
                descriptors[1].matchesReturnValue = true
                expect { try swinject.instance(of: Any.self) }.notTo(throwError())
            }
            it("returns instance from matching binding") {
                descriptors[1].matchesReturnValue = true
                bindings[1].instanceUsingReturnValue = 42
                expect { try swinject.instance(of: Int.self) } == 42
            }
        }
    }
    describe("provider injection") {
        var swinject: Swinject!
        var binding = AnyBindingMock()
        var descriptor = AnyTypeDescriptorMock()
        beforeEach {
            binding = AnyBindingMock()
            descriptor = AnyTypeDescriptorMock()
            swinject = Swinject { bbind(descriptor) & binding }
        }
        it("does not throw if binding matches provided type") {
            descriptor.matchesReturnValue = true
            binding.instanceUsingReturnValue = 42
            expect { try swinject.provider(of: Int.self) }.notTo(throwError())
        }
        it("throws if missing binding for provided type") {
            descriptor.matchesReturnValue = false
            expect { try swinject.provider(of: Int.self) }.to(throwError())
        }
        it("does not request provided type until provider is called") {
            descriptor.matchesReturnValue = true
            binding.instanceUsingReturnValue = 42
            _ = try? swinject.provider(of: Int.self)
            expect(binding.instanceUsingCallsCount) == 0
        }
        it("returns instance from binding") {
            descriptor.matchesReturnValue = true
            binding.instanceUsingReturnValue = 42
            expect { try swinject.provider(of: Int.self)() } == 42
        }
        it("rethrows binding error from provider") {
            descriptor.matchesReturnValue = true
            binding.instanceUsingThrowableError = TestError()
            expect { try swinject.provider(of: Int.self)() }.to(throwError(errorType: TestError.self))
        }
    }
} }
