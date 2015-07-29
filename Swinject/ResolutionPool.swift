//
//  ResolutionPool.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/28/15.
//  Copyright (c) 2015 DevSwinject. All rights reserved.
//

import Foundation

internal struct ResolutionPool {
    private var pool = [ServiceKey: AnyObject]()
    private var depth: Int = 0
    
    internal subscript(key: ServiceKey) -> AnyObject? {
        get { return pool[key] }
        set { pool[key] = newValue }
    }
    
    internal mutating func incrementDepth() {
        depth++
    }
    
    internal mutating func decrementDepth() {
        assert(depth > 0, "The depth cannot be negative.")
        
        depth--
        if depth == 0 {
            pool = [:]
        }
    }
}
