//
//  LinuxMain.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 11/25/16.
//  Copyright © 2016 Swinject Contributors. All rights reserved.
//

import XCTest
import Quick

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
    ServiceEntrySpec.self
])
