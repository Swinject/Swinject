//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct BinderEnvironment<Context> {}

public func contexted<Context>(_: Context.Type = Context.self) -> BinderEnvironment<Context> {
    BinderEnvironment()
}
