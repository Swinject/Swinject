//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

extension Swinject {
    public struct Module {
        let name: String
        let tree: SwinjectTree
        let allowsSilentOverride: Bool
    }
}

public struct ModuleInclusion: SwinjectEntry {
    let module: Swinject.Module
    let canOverride: Bool
}

// TODO: This should only be allowed on top level
public func include(_ module: Swinject.Module, allowToOverride: Bool = false) -> ModuleInclusion {
    return ModuleInclusion(
        module: module,
        canOverride: allowToOverride || module.allowsSilentOverride
    )
}
