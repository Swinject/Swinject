//
//  SpinLock.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 11/26/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Foundation

internal final class SpinLock {
    private let lock =  NSLock()
    private let throwsLock =  NSLock()

    func sync<T>(action: () -> T) -> T {
        lock.lock()
        defer { lock.unlock() }
        return action()
    }

    func throwsSync<T>(action: () throws -> T)  throws -> T {
        lock.lock()
        defer { lock.unlock() }
        return try action()
    }
}
