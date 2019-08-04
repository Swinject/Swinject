//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public protocol AnyScope {
    var contextType: Any.Type { get }
    func registry(for context: Any) -> ScopeRegistry
}

public protocol Scope: AnyScope {
    associatedtype Context
    func registry(for context: Context) -> ScopeRegistry
}

public extension Scope {
    var contextType: Any.Type { return Context.self }

    func registry(for context: Any) -> ScopeRegistry {
        return registry(for: context as! Context)
    }
}

public protocol Closable {
    func close()
}
