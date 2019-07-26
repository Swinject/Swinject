//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// sourcery: AutoMockable
public protocol Matchable {
    func matches(_ other: Any) -> Bool
    func hash(into hasher: inout Hasher)
}

// TODO: Can we make ArgumentBox types internal?
// swiftlint:disable line_length
// swiftlint:disable large_tuple
// sourcery:inline:ArgumentBox
public struct ArgumentBox1<Arg1>: Matchable where Arg1: Hashable {
    let arg1: Arg1

    public func matches(_ other: Any) -> Bool {
        guard let other = other as? ArgumentBox1<Arg1> else { return false }
        return arg1 == other.arg1
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(arg1)
    }
}

public struct ArgumentBox2<Arg1, Arg2>: Matchable where Arg1: Hashable, Arg2: Hashable {
    let arg1: Arg1
    let arg2: Arg2

    public func matches(_ other: Any) -> Bool {
        guard let other = other as? ArgumentBox2<Arg1, Arg2> else { return false }
        return arg1 == other.arg1 && arg2 == other.arg2
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(arg1)
        hasher.combine(arg2)
    }
}

public struct ArgumentBox3<Arg1, Arg2, Arg3>: Matchable where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable {
    let arg1: Arg1
    let arg2: Arg2
    let arg3: Arg3

    public func matches(_ other: Any) -> Bool {
        guard let other = other as? ArgumentBox3<Arg1, Arg2, Arg3> else { return false }
        return arg1 == other.arg1 && arg2 == other.arg2 && arg3 == other.arg3
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(arg1)
        hasher.combine(arg2)
        hasher.combine(arg3)
    }
}

public struct ArgumentBox4<Arg1, Arg2, Arg3, Arg4>: Matchable where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable {
    let arg1: Arg1
    let arg2: Arg2
    let arg3: Arg3
    let arg4: Arg4

    public func matches(_ other: Any) -> Bool {
        guard let other = other as? ArgumentBox4<Arg1, Arg2, Arg3, Arg4> else { return false }
        return arg1 == other.arg1 && arg2 == other.arg2 && arg3 == other.arg3 && arg4 == other.arg4
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(arg1)
        hasher.combine(arg2)
        hasher.combine(arg3)
        hasher.combine(arg4)
    }
}

public struct ArgumentBox5<Arg1, Arg2, Arg3, Arg4, Arg5>: Matchable where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable, Arg5: Hashable {
    let arg1: Arg1
    let arg2: Arg2
    let arg3: Arg3
    let arg4: Arg4
    let arg5: Arg5

    public func matches(_ other: Any) -> Bool {
        guard let other = other as? ArgumentBox5<Arg1, Arg2, Arg3, Arg4, Arg5> else { return false }
        return arg1 == other.arg1 && arg2 == other.arg2 && arg3 == other.arg3 && arg4 == other.arg4 && arg5 == other.arg5
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(arg1)
        hasher.combine(arg2)
        hasher.combine(arg3)
        hasher.combine(arg4)
        hasher.combine(arg5)
    }
}

func pack<Arg1>(_ arg1: Arg1) -> Arg1 {
    arg1
}

func pack<Arg1>(_ arg1: Arg1) -> ArgumentBox1<Arg1> where Arg1: Hashable {
    ArgumentBox1(arg1: arg1)
}

func pack<Arg1, Arg2>(_ arg1: Arg1, _ arg2: Arg2) -> (Arg1, Arg2) {
    (arg1, arg2)
}

func pack<Arg1, Arg2>(_ arg1: Arg1, _ arg2: Arg2) -> ArgumentBox2<Arg1, Arg2> where Arg1: Hashable, Arg2: Hashable {
    ArgumentBox2(arg1: arg1, arg2: arg2)
}

func pack<Arg1, Arg2, Arg3>(_ arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> (Arg1, Arg2, Arg3) {
    (arg1, arg2, arg3)
}

func pack<Arg1, Arg2, Arg3>(_ arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> ArgumentBox3<Arg1, Arg2, Arg3> where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable {
    ArgumentBox3(arg1: arg1, arg2: arg2, arg3: arg3)
}

func pack<Arg1, Arg2, Arg3, Arg4>(_ arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) -> (Arg1, Arg2, Arg3, Arg4) {
    (arg1, arg2, arg3, arg4)
}

func pack<Arg1, Arg2, Arg3, Arg4>(_ arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) -> ArgumentBox4<Arg1, Arg2, Arg3, Arg4> where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable {
    ArgumentBox4(arg1: arg1, arg2: arg2, arg3: arg3, arg4: arg4)
}

func pack<Arg1, Arg2, Arg3, Arg4, Arg5>(_ arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5) -> (Arg1, Arg2, Arg3, Arg4, Arg5) {
    (arg1, arg2, arg3, arg4, arg5)
}

func pack<Arg1, Arg2, Arg3, Arg4, Arg5>(_ arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5) -> ArgumentBox5<Arg1, Arg2, Arg3, Arg4, Arg5> where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable, Arg5: Hashable {
    ArgumentBox5(arg1: arg1, arg2: arg2, arg3: arg3, arg4: arg4, arg5: arg5)
}

// sourcery:end
