//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Quick
import Nimble
import Swinject

class SwinjectSpec: QuickSpec { override func spec() {
    describe("injection") {
        context("no bindings") {
            it("throws") {
                let swinject = Swinject { }
                expect { try swinject.instance(of: Int.self) }.to(throwError())
            }
        }
        context("single binding") {
            var swinject: Swinject!
            var fakeBinding: FakeBinding<Int>!
            var fakeDescriptor: FakeDescriptor<Int>!
            beforeEach {
                fakeBinding = FakeBinding(0)
                fakeDescriptor = FakeDescriptor()
                swinject = Swinject { bbind(fakeDescriptor) & fakeBinding }
            }
            it("request instance from matching binding") {
                fakeDescriptor.shouldMatch = { _ in true }
                _ = try? swinject.instance(of: Int.self)
                expect(fakeBinding.instanceRequestCount) == 1
            }
            it("does not request instance from matching binding until instance is required") {
                fakeDescriptor.shouldMatch = { _ in true }
                expect(fakeBinding.instanceRequestCount) == 0
            }
            it("only requests instance from matching binding") {
                fakeDescriptor.shouldMatch = { _ in false }
                _ = try? swinject.instance(of: Int.self)
                expect(fakeBinding.instanceRequestCount) == 0
            }
            it("returns instance produced by binding") {
                fakeDescriptor.shouldMatch = { _ in true }
                fakeBinding.instance = 42
                expect { try swinject.instance(of: Int.self) } == 42
            }
            it("rethrows error from binding") {
                fakeDescriptor.shouldMatch = { _ in true }
                fakeBinding.error = TestError()
                expect { try swinject.instance(of: Int.self) }.to(throwError(errorType: TestError.self))
            }
            it("throws if bound type does not match requested type") {
                fakeDescriptor.shouldMatch = { _ in true }
                expect { try swinject.instance(of: Double.self) }.to(throwError())
            }
            it("does not throw if bound type conforms to the requested type") {
                fakeDescriptor.shouldMatch = { _ in true }
                expect { try swinject.instance(of: CustomStringConvertible.self) }.notTo(throwError())
            }
        }
    }
}}
