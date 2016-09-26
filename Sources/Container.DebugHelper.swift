//
//  Container.DebugHelper.swift
//  Swinject
//
//  Created by Jakub Vaňo on 26/09/16.
//  Copyright © 2016 Swinject Contributors. All rights reserved.
//

internal extension Container {
    static var debugHelper: DebugHelper {
        get { return _debugHelper }
        set { _debugHelper = newValue }
    }
}

private var _debugHelper: DebugHelper = LoggingDebugHelper()
