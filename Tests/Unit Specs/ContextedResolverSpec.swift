//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Nimble
import Quick
@testable import Swinject

class ContextedResolverSpec: QuickSpec { override func spec() {
    var resolver: ContextedResolver<Void>!
    var wrapped = AnyResolverMock()
    beforeEach {
        wrapped = AnyResolverMock()
        wrapped.resolveReturnValue = 0
        resolver = ContextedResolver(context: (), resolver: wrapped)
    }
    describe("resolve") {
        it("returns value from wrapped resolver") {
            let intRequest = request(type: Int.self, tag: NoTag(), arg: ())
            wrapped.resolveReturnValue = 42
            expect { try resolver.resolve(intRequest) } == 42
        }
        it("calls wrapped resolver with given type descriptor") {
            let descriptor = AnyTypeDescriptorMock()
            let request = InstanceRequest<AnyTypeDescriptorMock, Void, Void>(
                key: BindingKey(descriptor: descriptor), context: (), argument: ()
            )
            _ = try? resolver.resolve(request)
            let receivedRequest = wrapped.resolveReceivedRequest as? InstanceRequest<AnyTypeDescriptorMock, Void, Void>
            expect(receivedRequest?.key.descriptor) === descriptor
        }
        it("calls wrapped resolver with given argument") {
            _ = try? resolver.resolve(request(type: Int.self, tag: NoTag(), arg: "argument"))
            let receivedRequest = wrapped.resolveReceivedRequest as? InstanceRequest<Tagged<Int, NoTag>, Void, String>
            expect(receivedRequest?.argument) == "argument"
        }
        it("calls wrapped resolver with it's context") {
            let resolver = ContextedResolver(context: "context", resolver: wrapped)
            _ = try? resolver.resolve(request(type: Int.self, tag: NoTag(), arg: ()))
            let receivedRequest = wrapped.resolveReceivedRequest as? InstanceRequest<Tagged<Int, NoTag>, String, Void>
            expect(receivedRequest?.context) == "context"
        }
    }
    describe("on context") {
        it("passes context to dependency resolution") {
            let binding = BindingMock()
            binding.matchesClosure = { $0.descriptor.matches(plain(Double.self)) }
            binding.instanceArgContextResolverReturnValue = 0.0
            let swinject = Swinject {
                bbind(Int.self) & provider { Int(try $0.instance() as Double) }
                binding
            }
            _ = try? swinject.on(42).instance(of: Int.self)
            expect(binding.instanceArgContextResolverReceivedArguments?.context as? Int) == 42
        }
    }
} }
