//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

import Foundation
import Nimble
@testable import Swinject

func concurrentPerform(iterations: Int, action: () -> Void) {
    var finished = 0
    DispatchQueue.concurrentPerform(iterations: iterations) { _ in
        action()
        finished += 1
    }
    waitUntil { done in
        if finished == iterations { done() }
    }
}

extension Matchable {
    var hashValue: Int { // swiftlint:disable:this legacy_hashing
        var hasher = Hasher()
        hash(into: &hasher)
        return hasher.finalize()
    }
}

extension Expectation {
    public func ifDebugTo(_ predicate: Predicate<T>, description: String? = nil) {
        #if DEBUG
            to(predicate, description: description)
        #else
            toNot(predicate, description: description)
        #endif
    }
}
