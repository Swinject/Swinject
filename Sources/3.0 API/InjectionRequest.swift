//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct InjectionRequest<Instance> {
    let inputs: [AnyPartialRequest]
    let execute: (Resolver, Arguments, inout Instance) throws -> Void
}

infix operator <-: AssignmentPrecedence

public func <- <Instance, Property, Request>(
    target: WritableKeyPath<Instance, Property>,
    request: Request
) -> InjectionRequest<Instance> where Request: PartialRequest, Request.Result == Property {
    return InjectionRequest(inputs: [request]) {
        $2[keyPath: target] = try request.fulfill(with: $0, and: $1)
    }
}
