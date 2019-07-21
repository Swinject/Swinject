//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// sourcery: AutoMockable
public protocol Matchable {
    func matches(_ other: Any) -> Bool
    var hashValue: Int { get } // FIXME: Use hash(into:)
}

// TODO: Box / Unbox internally all the arguments
struct AnyMatchable: Matchable, Hashable {
    let value: Any
    private let matchesValue: (Any) -> Bool
    private let hashValueInto: (inout Hasher) -> Void

    init<T: Hashable>(_ value: T) {
        self.value = value
        matchesValue = { $0 as? T == value }
        hashValueInto = { value.hash(into: &$0) }
    }

    func matches(_ other: Any) -> Bool {
        if let other = other as? AnyMatchable {
            return matchesValue(other.value)
        } else {
            return false
        }
    }

    func hash(into hasher: inout Hasher) {
        hashValueInto(&hasher)
    }

    static func == (lhs: AnyMatchable, rhs: AnyMatchable) -> Bool {
        lhs.matches(rhs.value)
    }
}
