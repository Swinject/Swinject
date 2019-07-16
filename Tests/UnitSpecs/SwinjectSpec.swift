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
            var key = AnyBindingKeyMock()
            beforeEach {
                binding = AnyBindingMock()
                key = AnyBindingKeyMock()
                swinject = Swinject { BindingEntry<Any>(key: key, binding: binding) }
            }
            it("request instance from matching binding") {
                key.matchesReturnValue = true
                _ = try? swinject.instance(of: Any.self)
                expect(binding.instanceArgInjectorCallsCount) == 1
            }
            it("does not request instance from matching binding until instance is required") {
                key.matchesReturnValue = true
                expect(binding.instanceArgInjectorCallsCount) == 0
            }
            it("only requests instance from matching binding") {
                key.matchesReturnValue = false
                _ = try? swinject.instance(of: Any.self)
                expect(binding.instanceArgInjectorCallsCount) == 0
            }
            it("returns instance produced by binding") {
                key.matchesReturnValue = true
                binding.instanceArgInjectorReturnValue = 42
                expect { try swinject.instance(of: Any.self) as? Int } == 42
            }
            it("rethrows error from binding") {
                key.matchesReturnValue = true
                binding.instanceArgInjectorThrowableError = TestError()
                expect { try swinject.instance(of: Any.self) }.to(throwError(errorType: TestError.self))
            }
            it("crashes if bound type does not match requested type") {
                key.matchesReturnValue = true
                binding.instanceArgInjectorReturnValue = ""
                expect { _ = try swinject.instance(of: Double.self) }.to(throwError())
            }
            it("does not crash if bound type conforms to the requested type") {
                key.matchesReturnValue = true
                binding.instanceArgInjectorReturnValue = 42
                expect { _ = try swinject.instance(of: CustomStringConvertible?.self) }.notTo(throwError())
            }
            it("passes swinject as injector") {
                key.matchesReturnValue = true
                _ = try? swinject.instance(of: Any.self)
                expect(binding.instanceArgInjectorReceivedArguments?.injector is Swinject).to(beTrue())
            }
            it("passes given argument to binding") {
                key.matchesReturnValue = true
                _ = try? swinject.instance(of: Any.self, arg: 42)
                expect(binding.instanceArgInjectorReceivedArguments?.arg as? Int) == 42
            }
        }
        context("multiple bindings") {
            var swinject: Swinject!
            var bindings = [AnyBindingMock]()
            var keys = [AnyBindingKeyMock]()
            beforeEach {
                keys = Array(0 ..< 3).map { _ in AnyBindingKeyMock() }
                keys.forEach { $0.matchesReturnValue = false }
                bindings = keys.map { _ in AnyBindingMock() }
                swinject = Swinject {
                    BindingEntry<Any>(key: keys[0], binding: bindings[0])
                    BindingEntry<Any>(key: keys[1], binding: bindings[1])
                    BindingEntry<Any>(key: keys[2], binding: bindings[2])
                }
            }
            it("throws if multiple entries match requested type") {
                keys.forEach { $0.matchesReturnValue = true }
                expect { try swinject.instance(of: Any.self) }.to(throwError())
            }
            it("does not throw if single entry matches requested type") {
                keys[1].matchesReturnValue = true
                expect { try swinject.instance(of: Any.self) }.notTo(throwError())
            }
            it("returns instance from matching binding") {
                keys[1].matchesReturnValue = true
                bindings[1].instanceArgInjectorReturnValue = 42
                expect { try swinject.instance(of: Int.self) } == 42
            }
        }
    }
    describe("provider injection") {
        var swinject: Swinject!
        var binding = AnyBindingMock()
        var key = AnyBindingKeyMock()
        beforeEach {
            binding = AnyBindingMock()
            key = AnyBindingKeyMock()
            swinject = Swinject { BindingEntry<Any>(key: key, binding: binding) }
        }
        it("does not throw if binding matches provided type") {
            key.matchesReturnValue = true
            binding.instanceArgInjectorReturnValue = 42
            expect { try swinject.provider(of: Int.self)() }.notTo(throwError())
        }
        it("throws if missing binding for provided type") {
            key.matchesReturnValue = false
            expect { try swinject.provider(of: Int.self)() }.to(throwError())
        }
        it("does not request provided type until provider is called") {
            key.matchesReturnValue = true
            binding.instanceArgInjectorReturnValue = 42
            _ = swinject.provider(of: Int.self)
            expect(binding.instanceArgInjectorCallsCount) == 0
        }
        it("returns instance from binding") {
            key.matchesReturnValue = true
            binding.instanceArgInjectorReturnValue = 42
            expect { try swinject.provider(of: Int.self)() } == 42
        }
        it("rethrows binding error from provider") {
            key.matchesReturnValue = true
            binding.instanceArgInjectorThrowableError = TestError()
            expect { try swinject.provider(of: Int.self)() }.to(throwError(errorType: TestError.self))
        }
        it("passes given argument to binding") {
            key.matchesReturnValue = true
            _ = try? swinject.provider(of: Any.self, arg: 42)()
            expect(binding.instanceArgInjectorReceivedArguments?.arg as? Int) == 42
        }
    }
} }
