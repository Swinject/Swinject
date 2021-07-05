//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import XCTest

@testable import SwinjectTests

XCTMain([
    testCase(AssemblerTests.allTests),
    testCase(ContainerTests.allTests),
    testCase(ContainerTests_Arguments.allTests),
    testCase(ContainerTests_Circularity.allTests),
    testCase(ContainerTests_DebugHelper.allTests),
    testCase(ContainerTests_CustomScope.allTests),
    testCase(SynchronizedResolverTests.allTests),
    testCase(ServiceKeyTests.allTests),
    testCase(ServiceEntryTests.allTests)
])

