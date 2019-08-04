//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// swiftlint:disable line_length
// sourcery:inline:ResolverFunctionCallApi
public extension Resolver {
    func call1<Output, P1>(_ function: (P1) -> Output) throws -> Output {
        return try function(instance())
    }

    func call<Output, P1, P2>(_ function: (P1, P2) -> Output) throws -> Output {
        return try function(instance(), instance())
    }

    func call<Output, P1, P2, P3>(_ function: (P1, P2, P3) -> Output) throws -> Output {
        return try function(instance(), instance(), instance())
    }

    func call<Output, P1, P2, P3, P4>(_ function: (P1, P2, P3, P4) -> Output) throws -> Output {
        return try function(instance(), instance(), instance(), instance())
    }

    func call<Output, P1, P2, P3, P4, P5>(_ function: (P1, P2, P3, P4, P5) -> Output) throws -> Output {
        return try function(instance(), instance(), instance(), instance(), instance())
    }

    func call<Output, P1, P2, P3, P4, P5, P6>(_ function: (P1, P2, P3, P4, P5, P6) -> Output) throws -> Output {
        return try function(instance(), instance(), instance(), instance(), instance(), instance())
    }

    func call<Output, P1, P2, P3, P4, P5, P6, P7>(_ function: (P1, P2, P3, P4, P5, P6, P7) -> Output) throws -> Output {
        return try function(instance(), instance(), instance(), instance(), instance(), instance(), instance())
    }

    func call<Output, P1, P2, P3, P4, P5, P6, P7, P8>(_ function: (P1, P2, P3, P4, P5, P6, P7, P8) -> Output) throws -> Output {
        return try function(instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance())
    }

    func call<Output, P1, P2, P3, P4, P5, P6, P7, P8, P9>(_ function: (P1, P2, P3, P4, P5, P6, P7, P8, P9) -> Output) throws -> Output {
        return try function(instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance())
    }

    func call<Output, P1, P2, P3, P4, P5, P6, P7, P8, P9, P10>(_ function: (P1, P2, P3, P4, P5, P6, P7, P8, P9, P10) -> Output) throws -> Output {
        return try function(instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance())
    }

    func call<Output, P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11>(_ function: (P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11) -> Output) throws -> Output {
        return try function(instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance())
    }

    func call<Output, P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12>(_ function: (P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12) -> Output) throws -> Output {
        return try function(instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance())
    }

    func call<Output, P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12, P13>(_ function: (P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12, P13) -> Output) throws -> Output {
        return try function(instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance())
    }

    func call<Output, P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12, P13, P14>(_ function: (P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12, P13, P14) -> Output) throws -> Output {
        return try function(instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance())
    }

    func call<Output, P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12, P13, P14, P15>(_ function: (P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12, P13, P14, P15) -> Output) throws -> Output {
        return try function(instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance())
    }

    func call<Output, P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12, P13, P14, P15, P16>(_ function: (P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12, P13, P14, P15, P16) -> Output) throws -> Output {
        return try function(instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance())
    }

    func call<Output, P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12, P13, P14, P15, P16, P17>(_ function: (P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12, P13, P14, P15, P16, P17) -> Output) throws -> Output {
        return try function(instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance())
    }

    func call<Output, P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12, P13, P14, P15, P16, P17, P18>(_ function: (P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12, P13, P14, P15, P16, P17, P18) -> Output) throws -> Output {
        return try function(instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance())
    }

    func call<Output, P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12, P13, P14, P15, P16, P17, P18, P19>(_ function: (P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12, P13, P14, P15, P16, P17, P18, P19) -> Output) throws -> Output {
        return try function(instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance())
    }

    func call<Output, P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12, P13, P14, P15, P16, P17, P18, P19, P20>(_ function: (P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12, P13, P14, P15, P16, P17, P18, P19, P20) -> Output) throws -> Output {
        return try function(instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance())
    }
}

// sourcery:end
