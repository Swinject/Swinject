//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

extension Swinject {
    public struct Module: SwinjectEntry {
        let name: String
        let tree: SwinjectTree
    }
}

public func include(_ module: Swinject.Module) -> Swinject.Module {
    return module
}
