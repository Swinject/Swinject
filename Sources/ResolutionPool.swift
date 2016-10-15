//
//  ResolutionPool.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/28/15.
//  Copyright (c) 2015 Swinject Contributors. All rights reserved.
//

import Foundation

internal class ResolutionPool: ObjectPool {
    private static let maxDepth = 200
    private var depth: Int = 0
    
    internal func incrementDepth() {
        guard depth < ResolutionPool.maxDepth else {
            fatalError("Infinite recursive call for circular dependency has been detected. " +
                       "To avoid the infinite call, 'initCompleted' handler should be used to inject circular dependency.")
        }
        depth += 1
    }
    
    internal func decrementDepth() {
        assert(depth > 0, "The depth cannot be negative.")
        
        depth -= 1
        if depth == 0 {
            pool = [:]
        }
    }
}
