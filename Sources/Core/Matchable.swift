//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// sourcery: AutoMockable
public protocol Matchable {
    func matches(_ other: Any) -> Bool
    func hash(into hasher: inout Hasher)
}

public extension Matchable where Self: Equatable {
    func matches(_ other: Any) -> Bool {
        self == (other as? Self)
    }
}

// swiftlint:disable line_length
// sourcery:inline:ArgumentBox
struct ArgumentBox1<Arg1>: Hashable, Matchable where Arg1: Hashable {
    let arg1: Arg1
}

struct ArgumentBox2<Arg1, Arg2>: Hashable, Matchable where Arg1: Hashable, Arg2: Hashable {
    let arg1: Arg1
    let arg2: Arg2
}

struct ArgumentBox3<Arg1, Arg2, Arg3>: Hashable, Matchable where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable {
    let arg1: Arg1
    let arg2: Arg2
    let arg3: Arg3
}

struct ArgumentBox4<Arg1, Arg2, Arg3, Arg4>: Hashable, Matchable where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable {
    let arg1: Arg1
    let arg2: Arg2
    let arg3: Arg3
    let arg4: Arg4
}

struct ArgumentBox5<Arg1, Arg2, Arg3, Arg4, Arg5>: Hashable, Matchable where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable, Arg5: Hashable {
    let arg1: Arg1
    let arg2: Arg2
    let arg3: Arg3
    let arg4: Arg4
    let arg5: Arg5
}

// sourcery:end
