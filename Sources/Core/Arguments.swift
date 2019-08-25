//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct Arguments {
    struct Descriptor {
        let types: [Any.Type]
    }

    let values: [Any]
    let descriptor: Descriptor

    func arg<Type>(_ index: Int) throws -> Type {
        guard (0 ..< values.count).contains(index) else { throw MissingArgument() }
        if let value = values[index] as? Type {
            return value
        }
        if let box = values[index] as? AnyMatchBox, let value = box.anyValue as? Type {
            return value
        }
        throw ArgumentMismatch()
    }
}

extension Arguments: Hashable {
    public func hash(into hasher: inout Hasher) {
        descriptor.hash(into: &hasher)
        values.forEach { ($0 as? Matchable)?.hash(into: &hasher) }
    }

    public static func == (lhs: Arguments, rhs: Arguments) -> Bool {
        return lhs.descriptor == rhs.descriptor
            && lhs.values.count == rhs.values.count
            && !zip(lhs.values, rhs.values).map(areValuesEqual).contains(false)
    }

    private static func areValuesEqual(_ lhs: Any, _ rhs: Any) -> Bool {
        switch (lhs, rhs) {
        case let (lhs as Matchable, _): return lhs.matches(rhs)
        case let (_, rhs as Matchable): return rhs.matches(lhs)
        default: return true
        }
    }
}

extension Arguments.Descriptor: Hashable {
    func hash(into hasher: inout Hasher) {
        types.map { ObjectIdentifier($0) }.hash(into: &hasher)
    }

    static func == (lhs: Arguments.Descriptor, rhs: Arguments.Descriptor) -> Bool {
        return lhs.types.count == rhs.types.count
            && zip(lhs.types, rhs.types).map { $0.0 == $0.1 }.allSatisfy { $0 == true }
    }
}

extension Arguments.Descriptor: ExpressibleByArrayLiteral {
    init(arrayLiteral types: Any.Type ...) {
        self.types = types
    }
}

extension Arguments {
    init() {
        values = []
        descriptor = []
    }

    // swiftlint:disable line_length
    // sourcery:inline:ArgumentVariations
    init<Arg1>(_ arg1: Arg1) {
        values = [arg1]
        descriptor = [Arg1.self]
    }

    init<Arg1>(_ arg1: Arg1) where Arg1: Hashable {
        values = [MatchBox(arg1)]
        descriptor = [Arg1.self]
    }

    init<Arg1, Arg2>(_ arg1: Arg1, _ arg2: Arg2) {
        values = [arg1, arg2]
        descriptor = [Arg1.self, Arg2.self]
    }

    init<Arg1, Arg2>(_ arg1: Arg1, _ arg2: Arg2) where Arg1: Hashable, Arg2: Hashable {
        values = [MatchBox(arg1), MatchBox(arg2)]
        descriptor = [Arg1.self, Arg2.self]
    }

    init<Arg1, Arg2, Arg3>(_ arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) {
        values = [arg1, arg2, arg3]
        descriptor = [Arg1.self, Arg2.self, Arg3.self]
    }

    init<Arg1, Arg2, Arg3>(_ arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable {
        values = [MatchBox(arg1), MatchBox(arg2), MatchBox(arg3)]
        descriptor = [Arg1.self, Arg2.self, Arg3.self]
    }

    init<Arg1, Arg2, Arg3, Arg4>(_ arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) {
        values = [arg1, arg2, arg3, arg4]
        descriptor = [Arg1.self, Arg2.self, Arg3.self, Arg4.self]
    }

    init<Arg1, Arg2, Arg3, Arg4>(_ arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable {
        values = [MatchBox(arg1), MatchBox(arg2), MatchBox(arg3), MatchBox(arg4)]
        descriptor = [Arg1.self, Arg2.self, Arg3.self, Arg4.self]
    }

    init<Arg1, Arg2, Arg3, Arg4, Arg5>(_ arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5) {
        values = [arg1, arg2, arg3, arg4, arg5]
        descriptor = [Arg1.self, Arg2.self, Arg3.self, Arg4.self, Arg5.self]
    }

    init<Arg1, Arg2, Arg3, Arg4, Arg5>(_ arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5) where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable, Arg5: Hashable {
        values = [MatchBox(arg1), MatchBox(arg2), MatchBox(arg3), MatchBox(arg4), MatchBox(arg5)]
        descriptor = [Arg1.self, Arg2.self, Arg3.self, Arg4.self, Arg5.self]
    }

    init<Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(_ arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6) {
        values = [arg1, arg2, arg3, arg4, arg5, arg6]
        descriptor = [Arg1.self, Arg2.self, Arg3.self, Arg4.self, Arg5.self, Arg6.self]
    }

    init<Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(_ arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6) where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable, Arg5: Hashable, Arg6: Hashable {
        values = [MatchBox(arg1), MatchBox(arg2), MatchBox(arg3), MatchBox(arg4), MatchBox(arg5), MatchBox(arg6)]
        descriptor = [Arg1.self, Arg2.self, Arg3.self, Arg4.self, Arg5.self, Arg6.self]
    }

    init<Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(_ arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7) {
        values = [arg1, arg2, arg3, arg4, arg5, arg6, arg7]
        descriptor = [Arg1.self, Arg2.self, Arg3.self, Arg4.self, Arg5.self, Arg6.self, Arg7.self]
    }

    init<Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(_ arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7) where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable, Arg5: Hashable, Arg6: Hashable, Arg7: Hashable {
        values = [MatchBox(arg1), MatchBox(arg2), MatchBox(arg3), MatchBox(arg4), MatchBox(arg5), MatchBox(arg6), MatchBox(arg7)]
        descriptor = [Arg1.self, Arg2.self, Arg3.self, Arg4.self, Arg5.self, Arg6.self, Arg7.self]
    }

    init<Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(_ arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7, _ arg8: Arg8) {
        values = [arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8]
        descriptor = [Arg1.self, Arg2.self, Arg3.self, Arg4.self, Arg5.self, Arg6.self, Arg7.self, Arg8.self]
    }

    init<Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(_ arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7, _ arg8: Arg8) where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable, Arg5: Hashable, Arg6: Hashable, Arg7: Hashable, Arg8: Hashable {
        values = [MatchBox(arg1), MatchBox(arg2), MatchBox(arg3), MatchBox(arg4), MatchBox(arg5), MatchBox(arg6), MatchBox(arg7), MatchBox(arg8)]
        descriptor = [Arg1.self, Arg2.self, Arg3.self, Arg4.self, Arg5.self, Arg6.self, Arg7.self, Arg8.self]
    }

    init<Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(_ arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7, _ arg8: Arg8, _ arg9: Arg9) {
        values = [arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9]
        descriptor = [Arg1.self, Arg2.self, Arg3.self, Arg4.self, Arg5.self, Arg6.self, Arg7.self, Arg8.self, Arg9.self]
    }

    init<Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(_ arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7, _ arg8: Arg8, _ arg9: Arg9) where Arg1: Hashable, Arg2: Hashable, Arg3: Hashable, Arg4: Hashable, Arg5: Hashable, Arg6: Hashable, Arg7: Hashable, Arg8: Hashable, Arg9: Hashable {
        values = [MatchBox(arg1), MatchBox(arg2), MatchBox(arg3), MatchBox(arg4), MatchBox(arg5), MatchBox(arg6), MatchBox(arg7), MatchBox(arg8), MatchBox(arg9)]
        descriptor = [Arg1.self, Arg2.self, Arg3.self, Arg4.self, Arg5.self, Arg6.self, Arg7.self, Arg8.self, Arg9.self]
    }

    // sourcery:end
}
