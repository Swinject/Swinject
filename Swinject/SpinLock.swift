//
//  SpinLock.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 11/26/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

internal final class SpinLock {
    private var lock = OS_SPINLOCK_INIT
    
    func sync<T>(@noescape action: () -> T) -> T {
        OSSpinLockLock(&lock)
        defer { OSSpinLockUnlock(&lock) }

        return action()
    }
}
