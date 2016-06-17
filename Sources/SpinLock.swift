//
//  SpinLock.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 11/26/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Foundation

internal final class SpinLock {
    private let lock = Lock()
    
    func sync<T>(action: @noescape () -> T) -> T {
        lock.lock()
        defer { lock.unlock() }
        return action()
    }
}
