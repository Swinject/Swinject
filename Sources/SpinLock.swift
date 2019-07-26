//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Foundation

internal final class SpinLock {
    private let lock = NSRecursiveLock()

    func sync<T>(action: () -> T) -> T {
        lock.lock()
        defer { lock.unlock() }
        return action()
    }
}
