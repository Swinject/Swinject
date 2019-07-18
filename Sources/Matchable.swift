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
    private let _matches: (Any) -> Bool
    private let _hashInto: (inout Hasher) -> Void

    init<T: Hashable>(_ value: T) {
        self.value = value
        _matches = { $0 as? T == value }
        _hashInto = { value.hash(into: &$0) }
    }

    func matches(_ other: Any) -> Bool {
        _matches(other)
    }

    func hash(into hasher: inout Hasher) {
        _hashInto(&hasher)
    }

    static func == (lhs: AnyMatchable, rhs: AnyMatchable) -> Bool {
        lhs.matches(rhs.value)
    }
}
