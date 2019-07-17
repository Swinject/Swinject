//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct BinderEnvironment<AScope, Context> {
    let scope: AScope
}

public func contexted<Context>(_: Context.Type = Context.self) -> BinderEnvironment<Void, Context> {
    BinderEnvironment(scope: ())
}

public func scoped<AScope>(_ scope: AScope) -> BinderEnvironment<AScope, AScope.Context> where AScope: Scope {
    BinderEnvironment(scope: scope)
}
