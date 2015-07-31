//
//  ResolutionPool.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/28/15.
//  Copyright (c) 2015 Swinject Contributors. All rights reserved.
//

import Foundation

internal struct ResolutionPool {
    private static let MaxDepth = 200
    
    private var pool = [ServiceKey: Any]()
    private var depth: Int = 0
    
    internal subscript(key: ServiceKey) -> Any? {
        get { return pool[key] }
        set { pool[key] = newValue }
    }
    
    internal mutating func incrementDepth() {
        depth++
        
        if depth > ResolutionPool.MaxDepth {
            // Raises an exception to tell the problem to programmers. (Usually just crashes the program.)
            // No error is thrown intentionally to avoid 'try' every time to resolve a service.
            let e = NSException(
                name: "SwinjectInfiniteRecursiveCall",
                reason: "Infinite recursive call for circular dependency has been detected. " +
                        "To avoid the infinite call, 'initCompleted' handler should be used to inject circular dependency.",
                userInfo: nil)
            e.raise()
        }
    }
    
    internal mutating func decrementDepth() {
        assert(depth > 0, "The depth cannot be negative.")
        
        depth--
        if depth == 0 {
            pool = [:]
        }
    }
}
