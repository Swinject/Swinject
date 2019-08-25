//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public protocol Matchable {
    func matches(_ other: Any) -> Bool
    func hash(into hasher: inout Hasher)
}

public extension Matchable where Self: Equatable {
    func matches(_ other: Any) -> Bool {
        return self == (other as? Self)
    }
}

protocol AnyMatchBox: Matchable {
    var anyValue: Any { get }
}

struct MatchBox<Value>: Hashable, AnyMatchBox where Value: Hashable {
    let value: Value

    init(_ value: Value) {
        self.value = value
    }

    var anyValue: Any { return value }
}
