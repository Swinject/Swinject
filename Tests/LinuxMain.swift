//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import XCTest

@testable import SwinjectTests

XCTMain([
    testCase(AssemblerTests.allTests),
    testCase(ContainerTests.allTests),
    testCase(ContainerTests.Arguments.allTests),
    testCase(ContainerTests.Circularity.allTests),
    testCase(ContainerTests.DebugHelper.allTests),
    testCase(ContainerTests.CustomScope.allTests),
    testCase(SynchronizedResolverTests.allTests),
    testCase(erviceKeyTests.allTests),
    testCase(ServiceEntryTests.allTests)
])