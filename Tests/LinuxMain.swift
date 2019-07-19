//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Quick
import XCTest

@testable import SwinjectTests

Quick.QCKMain([
    AssemblerSpec.self,
    ContainerSpec.self,
    ContainerSpec_Arguments.self,
    ContainerSpec_Circularity.self,
    ContainerSpec_DebugHelper.self,
    ContainerSpec_CustomScope.self,
    SynchronizedResolverSpec.self,
    ServiceKeySpec.self,
    ServiceEntrySpec.self,
])
