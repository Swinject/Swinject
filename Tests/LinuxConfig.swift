//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Quick

let allSpecs: [QuickSpec.Type] = [
    // 2.0 Api
    AssemblerSpec.self,
    ContainerSpec_Arguments.self,
    ContainerSpec_Circularity.self,
    ContainerSpec_Behavior.self,
    ContainerSpec_CustomStringConvertible.self,
    ContainerSpec.self,
    ContainerSpec_TypeForwarding.self,
    LazySpec.self,
    ProviderSpec.self,
    SynchronizedResolverSpec.self,
    // 3.0 Api
    SwinjectApiSpec.self,
    BindingSpec.self,
    ModulesSpec.self,
    ScopesSpec.self,
    OptionalsSpec.self,
    // Unit Specs
    BinderEnvironmentSpec.self,
    BindingKeySpec.self,
    ReferenceMakerSpec.self,
    ScopedBindingSpec.self,
    ScopeRegistryKeySpec.self,
    SimpleBindingSpec.self,
    StandardScopeRegistrySpec.self,
    SwinjectSpec.self,
    SwinjectTreeBuilderSpec.self,
    TaggedTypeSpec.self,
]
