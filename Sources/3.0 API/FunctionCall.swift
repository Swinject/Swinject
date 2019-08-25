//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public struct FunctionCall<Result> {
    let inputs: [AnyPartialRequest]
    let execute: (Resolver, Arguments) throws -> Result
}

postfix operator ^

// swiftlint:disable line_length
// swiftlint:disable large_tuple
// swiftformat:disable spaceAroundOperators redundantParens
// sourcery:inline:FunctionCallVariations
public postfix func ^ <Result>(function: @escaping () throws -> Result) -> FunctionCall<Result> {
    return function^()
}

public postfix func ^ <Result, I1>(function: @escaping (I1) throws -> Result) -> FunctionCall<Result> {
    return function^(instance())
}

public postfix func ^ <Result, I1, I2>(function: @escaping (I1, I2) throws -> Result) -> FunctionCall<Result> {
    return function^(instance(), instance())
}

public postfix func ^ <Result, I1, I2, I3>(function: @escaping (I1, I2, I3) throws -> Result) -> FunctionCall<Result> {
    return function^(instance(), instance(), instance())
}

public postfix func ^ <Result, I1, I2, I3, I4>(function: @escaping (I1, I2, I3, I4) throws -> Result) -> FunctionCall<Result> {
    return function^(instance(), instance(), instance(), instance())
}

public postfix func ^ <Result, I1, I2, I3, I4, I5>(function: @escaping (I1, I2, I3, I4, I5) throws -> Result) -> FunctionCall<Result> {
    return function^(instance(), instance(), instance(), instance(), instance())
}

public postfix func ^ <Result, I1, I2, I3, I4, I5, I6>(function: @escaping (I1, I2, I3, I4, I5, I6) throws -> Result) -> FunctionCall<Result> {
    return function^(instance(), instance(), instance(), instance(), instance(), instance())
}

public postfix func ^ <Result, I1, I2, I3, I4, I5, I6, I7>(function: @escaping (I1, I2, I3, I4, I5, I6, I7) throws -> Result) -> FunctionCall<Result> {
    return function^(instance(), instance(), instance(), instance(), instance(), instance(), instance())
}

public postfix func ^ <Result, I1, I2, I3, I4, I5, I6, I7, I8>(function: @escaping (I1, I2, I3, I4, I5, I6, I7, I8) throws -> Result) -> FunctionCall<Result> {
    return function^(instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance())
}

public postfix func ^ <Result, I1, I2, I3, I4, I5, I6, I7, I8, I9>(function: @escaping (I1, I2, I3, I4, I5, I6, I7, I8, I9) throws -> Result) -> FunctionCall<Result> {
    return function^(instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance())
}

public postfix func ^ <Result, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10>(function: @escaping (I1, I2, I3, I4, I5, I6, I7, I8, I9, I10) throws -> Result) -> FunctionCall<Result> {
    return function^(instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance())
}

public postfix func ^ <Result, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11>(function: @escaping (I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11) throws -> Result) -> FunctionCall<Result> {
    return function^(instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance())
}

public postfix func ^ <Result, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12>(function: @escaping (I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12) throws -> Result) -> FunctionCall<Result> {
    return function^(instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance())
}

public postfix func ^ <Result, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13>(function: @escaping (I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13) throws -> Result) -> FunctionCall<Result> {
    return function^(instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance())
}

public postfix func ^ <Result, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14>(function: @escaping (I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14) throws -> Result) -> FunctionCall<Result> {
    return function^(instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance())
}

public postfix func ^ <Result, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15>(function: @escaping (I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15) throws -> Result) -> FunctionCall<Result> {
    return function^(instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance())
}

public postfix func ^ <Result, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15, I16>(function: @escaping (I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15, I16) throws -> Result) -> FunctionCall<Result> {
    return function^(instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance())
}

public postfix func ^ <Result, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15, I16, I17>(function: @escaping (I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15, I16, I17) throws -> Result) -> FunctionCall<Result> {
    return function^(instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance())
}

public postfix func ^ <Result, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15, I16, I17, I18>(function: @escaping (I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15, I16, I17, I18) throws -> Result) -> FunctionCall<Result> {
    return function^(instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance())
}

public postfix func ^ <Result, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15, I16, I17, I18, I19>(function: @escaping (I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15, I16, I17, I18, I19) throws -> Result) -> FunctionCall<Result> {
    return function^(instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance())
}

public postfix func ^ <Result, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15, I16, I17, I18, I19, I20>(function: @escaping (I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15, I16, I17, I18, I19, I20) throws -> Result) -> FunctionCall<Result> {
    return function^(instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance(), instance())
}

public func ^ <Result>(function: @escaping () throws -> Result, _: ()) -> FunctionCall<Result> {
    return FunctionCall(inputs: []) { _, _ in
        try function()
    }
}

public func ^ <Result, R1>(function: @escaping (R1.Result) throws -> Result, inputs: (R1)) -> FunctionCall<Result> where R1: PartialRequest {
    return FunctionCall(inputs: [inputs]) {
        try function(inputs.fulfill(with: $0, and: $1))
    }
}

public func ^ <Result, R1, R2>(function: @escaping (R1.Result, R2.Result) throws -> Result, inputs: (R1, R2)) -> FunctionCall<Result> where R1: PartialRequest, R2: PartialRequest {
    return FunctionCall(inputs: [inputs.0, inputs.1]) {
        try function(inputs.0.fulfill(with: $0, and: $1), inputs.1.fulfill(with: $0, and: $1))
    }
}

public func ^ <Result, R1, R2, R3>(function: @escaping (R1.Result, R2.Result, R3.Result) throws -> Result, inputs: (R1, R2, R3)) -> FunctionCall<Result> where R1: PartialRequest, R2: PartialRequest, R3: PartialRequest {
    return FunctionCall(inputs: [inputs.0, inputs.1, inputs.2]) {
        try function(inputs.0.fulfill(with: $0, and: $1), inputs.1.fulfill(with: $0, and: $1), inputs.2.fulfill(with: $0, and: $1))
    }
}

public func ^ <Result, R1, R2, R3, R4>(function: @escaping (R1.Result, R2.Result, R3.Result, R4.Result) throws -> Result, inputs: (R1, R2, R3, R4)) -> FunctionCall<Result> where R1: PartialRequest, R2: PartialRequest, R3: PartialRequest, R4: PartialRequest {
    return FunctionCall(inputs: [inputs.0, inputs.1, inputs.2, inputs.3]) {
        try function(inputs.0.fulfill(with: $0, and: $1), inputs.1.fulfill(with: $0, and: $1), inputs.2.fulfill(with: $0, and: $1), inputs.3.fulfill(with: $0, and: $1))
    }
}

public func ^ <Result, R1, R2, R3, R4, R5>(function: @escaping (R1.Result, R2.Result, R3.Result, R4.Result, R5.Result) throws -> Result, inputs: (R1, R2, R3, R4, R5)) -> FunctionCall<Result> where R1: PartialRequest, R2: PartialRequest, R3: PartialRequest, R4: PartialRequest, R5: PartialRequest {
    return FunctionCall(inputs: [inputs.0, inputs.1, inputs.2, inputs.3, inputs.4]) {
        try function(inputs.0.fulfill(with: $0, and: $1), inputs.1.fulfill(with: $0, and: $1), inputs.2.fulfill(with: $0, and: $1), inputs.3.fulfill(with: $0, and: $1), inputs.4.fulfill(with: $0, and: $1))
    }
}

public func ^ <Result, R1, R2, R3, R4, R5, R6>(function: @escaping (R1.Result, R2.Result, R3.Result, R4.Result, R5.Result, R6.Result) throws -> Result, inputs: (R1, R2, R3, R4, R5, R6)) -> FunctionCall<Result> where R1: PartialRequest, R2: PartialRequest, R3: PartialRequest, R4: PartialRequest, R5: PartialRequest, R6: PartialRequest {
    return FunctionCall(inputs: [inputs.0, inputs.1, inputs.2, inputs.3, inputs.4, inputs.5]) {
        try function(inputs.0.fulfill(with: $0, and: $1), inputs.1.fulfill(with: $0, and: $1), inputs.2.fulfill(with: $0, and: $1), inputs.3.fulfill(with: $0, and: $1), inputs.4.fulfill(with: $0, and: $1), inputs.5.fulfill(with: $0, and: $1))
    }
}

public func ^ <Result, R1, R2, R3, R4, R5, R6, R7>(function: @escaping (R1.Result, R2.Result, R3.Result, R4.Result, R5.Result, R6.Result, R7.Result) throws -> Result, inputs: (R1, R2, R3, R4, R5, R6, R7)) -> FunctionCall<Result> where R1: PartialRequest, R2: PartialRequest, R3: PartialRequest, R4: PartialRequest, R5: PartialRequest, R6: PartialRequest, R7: PartialRequest {
    return FunctionCall(inputs: [inputs.0, inputs.1, inputs.2, inputs.3, inputs.4, inputs.5, inputs.6]) {
        try function(inputs.0.fulfill(with: $0, and: $1), inputs.1.fulfill(with: $0, and: $1), inputs.2.fulfill(with: $0, and: $1), inputs.3.fulfill(with: $0, and: $1), inputs.4.fulfill(with: $0, and: $1), inputs.5.fulfill(with: $0, and: $1), inputs.6.fulfill(with: $0, and: $1))
    }
}

public func ^ <Result, R1, R2, R3, R4, R5, R6, R7, R8>(function: @escaping (R1.Result, R2.Result, R3.Result, R4.Result, R5.Result, R6.Result, R7.Result, R8.Result) throws -> Result, inputs: (R1, R2, R3, R4, R5, R6, R7, R8)) -> FunctionCall<Result> where R1: PartialRequest, R2: PartialRequest, R3: PartialRequest, R4: PartialRequest, R5: PartialRequest, R6: PartialRequest, R7: PartialRequest, R8: PartialRequest {
    return FunctionCall(inputs: [inputs.0, inputs.1, inputs.2, inputs.3, inputs.4, inputs.5, inputs.6, inputs.7]) {
        try function(inputs.0.fulfill(with: $0, and: $1), inputs.1.fulfill(with: $0, and: $1), inputs.2.fulfill(with: $0, and: $1), inputs.3.fulfill(with: $0, and: $1), inputs.4.fulfill(with: $0, and: $1), inputs.5.fulfill(with: $0, and: $1), inputs.6.fulfill(with: $0, and: $1), inputs.7.fulfill(with: $0, and: $1))
    }
}

public func ^ <Result, R1, R2, R3, R4, R5, R6, R7, R8, R9>(function: @escaping (R1.Result, R2.Result, R3.Result, R4.Result, R5.Result, R6.Result, R7.Result, R8.Result, R9.Result) throws -> Result, inputs: (R1, R2, R3, R4, R5, R6, R7, R8, R9)) -> FunctionCall<Result> where R1: PartialRequest, R2: PartialRequest, R3: PartialRequest, R4: PartialRequest, R5: PartialRequest, R6: PartialRequest, R7: PartialRequest, R8: PartialRequest, R9: PartialRequest {
    return FunctionCall(inputs: [inputs.0, inputs.1, inputs.2, inputs.3, inputs.4, inputs.5, inputs.6, inputs.7, inputs.8]) {
        try function(inputs.0.fulfill(with: $0, and: $1), inputs.1.fulfill(with: $0, and: $1), inputs.2.fulfill(with: $0, and: $1), inputs.3.fulfill(with: $0, and: $1), inputs.4.fulfill(with: $0, and: $1), inputs.5.fulfill(with: $0, and: $1), inputs.6.fulfill(with: $0, and: $1), inputs.7.fulfill(with: $0, and: $1), inputs.8.fulfill(with: $0, and: $1))
    }
}

public func ^ <Result, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10>(function: @escaping (R1.Result, R2.Result, R3.Result, R4.Result, R5.Result, R6.Result, R7.Result, R8.Result, R9.Result, R10.Result) throws -> Result, inputs: (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10)) -> FunctionCall<Result> where R1: PartialRequest, R2: PartialRequest, R3: PartialRequest, R4: PartialRequest, R5: PartialRequest, R6: PartialRequest, R7: PartialRequest, R8: PartialRequest, R9: PartialRequest, R10: PartialRequest {
    return FunctionCall(inputs: [inputs.0, inputs.1, inputs.2, inputs.3, inputs.4, inputs.5, inputs.6, inputs.7, inputs.8, inputs.9]) {
        try function(inputs.0.fulfill(with: $0, and: $1), inputs.1.fulfill(with: $0, and: $1), inputs.2.fulfill(with: $0, and: $1), inputs.3.fulfill(with: $0, and: $1), inputs.4.fulfill(with: $0, and: $1), inputs.5.fulfill(with: $0, and: $1), inputs.6.fulfill(with: $0, and: $1), inputs.7.fulfill(with: $0, and: $1), inputs.8.fulfill(with: $0, and: $1), inputs.9.fulfill(with: $0, and: $1))
    }
}

public func ^ <Result, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11>(function: @escaping (R1.Result, R2.Result, R3.Result, R4.Result, R5.Result, R6.Result, R7.Result, R8.Result, R9.Result, R10.Result, R11.Result) throws -> Result, inputs: (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11)) -> FunctionCall<Result> where R1: PartialRequest, R2: PartialRequest, R3: PartialRequest, R4: PartialRequest, R5: PartialRequest, R6: PartialRequest, R7: PartialRequest, R8: PartialRequest, R9: PartialRequest, R10: PartialRequest, R11: PartialRequest {
    return FunctionCall(inputs: [inputs.0, inputs.1, inputs.2, inputs.3, inputs.4, inputs.5, inputs.6, inputs.7, inputs.8, inputs.9, inputs.10]) {
        try function(inputs.0.fulfill(with: $0, and: $1), inputs.1.fulfill(with: $0, and: $1), inputs.2.fulfill(with: $0, and: $1), inputs.3.fulfill(with: $0, and: $1), inputs.4.fulfill(with: $0, and: $1), inputs.5.fulfill(with: $0, and: $1), inputs.6.fulfill(with: $0, and: $1), inputs.7.fulfill(with: $0, and: $1), inputs.8.fulfill(with: $0, and: $1), inputs.9.fulfill(with: $0, and: $1), inputs.10.fulfill(with: $0, and: $1))
    }
}

public func ^ <Result, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12>(function: @escaping (R1.Result, R2.Result, R3.Result, R4.Result, R5.Result, R6.Result, R7.Result, R8.Result, R9.Result, R10.Result, R11.Result, R12.Result) throws -> Result, inputs: (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12)) -> FunctionCall<Result> where R1: PartialRequest, R2: PartialRequest, R3: PartialRequest, R4: PartialRequest, R5: PartialRequest, R6: PartialRequest, R7: PartialRequest, R8: PartialRequest, R9: PartialRequest, R10: PartialRequest, R11: PartialRequest, R12: PartialRequest {
    return FunctionCall(inputs: [inputs.0, inputs.1, inputs.2, inputs.3, inputs.4, inputs.5, inputs.6, inputs.7, inputs.8, inputs.9, inputs.10, inputs.11]) {
        try function(inputs.0.fulfill(with: $0, and: $1), inputs.1.fulfill(with: $0, and: $1), inputs.2.fulfill(with: $0, and: $1), inputs.3.fulfill(with: $0, and: $1), inputs.4.fulfill(with: $0, and: $1), inputs.5.fulfill(with: $0, and: $1), inputs.6.fulfill(with: $0, and: $1), inputs.7.fulfill(with: $0, and: $1), inputs.8.fulfill(with: $0, and: $1), inputs.9.fulfill(with: $0, and: $1), inputs.10.fulfill(with: $0, and: $1), inputs.11.fulfill(with: $0, and: $1))
    }
}

public func ^ <Result, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13>(function: @escaping (R1.Result, R2.Result, R3.Result, R4.Result, R5.Result, R6.Result, R7.Result, R8.Result, R9.Result, R10.Result, R11.Result, R12.Result, R13.Result) throws -> Result, inputs: (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13)) -> FunctionCall<Result> where R1: PartialRequest, R2: PartialRequest, R3: PartialRequest, R4: PartialRequest, R5: PartialRequest, R6: PartialRequest, R7: PartialRequest, R8: PartialRequest, R9: PartialRequest, R10: PartialRequest, R11: PartialRequest, R12: PartialRequest, R13: PartialRequest {
    return FunctionCall(inputs: [inputs.0, inputs.1, inputs.2, inputs.3, inputs.4, inputs.5, inputs.6, inputs.7, inputs.8, inputs.9, inputs.10, inputs.11, inputs.12]) {
        try function(inputs.0.fulfill(with: $0, and: $1), inputs.1.fulfill(with: $0, and: $1), inputs.2.fulfill(with: $0, and: $1), inputs.3.fulfill(with: $0, and: $1), inputs.4.fulfill(with: $0, and: $1), inputs.5.fulfill(with: $0, and: $1), inputs.6.fulfill(with: $0, and: $1), inputs.7.fulfill(with: $0, and: $1), inputs.8.fulfill(with: $0, and: $1), inputs.9.fulfill(with: $0, and: $1), inputs.10.fulfill(with: $0, and: $1), inputs.11.fulfill(with: $0, and: $1), inputs.12.fulfill(with: $0, and: $1))
    }
}

public func ^ <Result, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14>(function: @escaping (R1.Result, R2.Result, R3.Result, R4.Result, R5.Result, R6.Result, R7.Result, R8.Result, R9.Result, R10.Result, R11.Result, R12.Result, R13.Result, R14.Result) throws -> Result, inputs: (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14)) -> FunctionCall<Result> where R1: PartialRequest, R2: PartialRequest, R3: PartialRequest, R4: PartialRequest, R5: PartialRequest, R6: PartialRequest, R7: PartialRequest, R8: PartialRequest, R9: PartialRequest, R10: PartialRequest, R11: PartialRequest, R12: PartialRequest, R13: PartialRequest, R14: PartialRequest {
    return FunctionCall(inputs: [inputs.0, inputs.1, inputs.2, inputs.3, inputs.4, inputs.5, inputs.6, inputs.7, inputs.8, inputs.9, inputs.10, inputs.11, inputs.12, inputs.13]) {
        try function(inputs.0.fulfill(with: $0, and: $1), inputs.1.fulfill(with: $0, and: $1), inputs.2.fulfill(with: $0, and: $1), inputs.3.fulfill(with: $0, and: $1), inputs.4.fulfill(with: $0, and: $1), inputs.5.fulfill(with: $0, and: $1), inputs.6.fulfill(with: $0, and: $1), inputs.7.fulfill(with: $0, and: $1), inputs.8.fulfill(with: $0, and: $1), inputs.9.fulfill(with: $0, and: $1), inputs.10.fulfill(with: $0, and: $1), inputs.11.fulfill(with: $0, and: $1), inputs.12.fulfill(with: $0, and: $1), inputs.13.fulfill(with: $0, and: $1))
    }
}

public func ^ <Result, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15>(function: @escaping (R1.Result, R2.Result, R3.Result, R4.Result, R5.Result, R6.Result, R7.Result, R8.Result, R9.Result, R10.Result, R11.Result, R12.Result, R13.Result, R14.Result, R15.Result) throws -> Result, inputs: (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15)) -> FunctionCall<Result> where R1: PartialRequest, R2: PartialRequest, R3: PartialRequest, R4: PartialRequest, R5: PartialRequest, R6: PartialRequest, R7: PartialRequest, R8: PartialRequest, R9: PartialRequest, R10: PartialRequest, R11: PartialRequest, R12: PartialRequest, R13: PartialRequest, R14: PartialRequest, R15: PartialRequest {
    return FunctionCall(inputs: [inputs.0, inputs.1, inputs.2, inputs.3, inputs.4, inputs.5, inputs.6, inputs.7, inputs.8, inputs.9, inputs.10, inputs.11, inputs.12, inputs.13, inputs.14]) {
        try function(inputs.0.fulfill(with: $0, and: $1), inputs.1.fulfill(with: $0, and: $1), inputs.2.fulfill(with: $0, and: $1), inputs.3.fulfill(with: $0, and: $1), inputs.4.fulfill(with: $0, and: $1), inputs.5.fulfill(with: $0, and: $1), inputs.6.fulfill(with: $0, and: $1), inputs.7.fulfill(with: $0, and: $1), inputs.8.fulfill(with: $0, and: $1), inputs.9.fulfill(with: $0, and: $1), inputs.10.fulfill(with: $0, and: $1), inputs.11.fulfill(with: $0, and: $1), inputs.12.fulfill(with: $0, and: $1), inputs.13.fulfill(with: $0, and: $1), inputs.14.fulfill(with: $0, and: $1))
    }
}

public func ^ <Result, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16>(function: @escaping (R1.Result, R2.Result, R3.Result, R4.Result, R5.Result, R6.Result, R7.Result, R8.Result, R9.Result, R10.Result, R11.Result, R12.Result, R13.Result, R14.Result, R15.Result, R16.Result) throws -> Result, inputs: (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16)) -> FunctionCall<Result> where R1: PartialRequest, R2: PartialRequest, R3: PartialRequest, R4: PartialRequest, R5: PartialRequest, R6: PartialRequest, R7: PartialRequest, R8: PartialRequest, R9: PartialRequest, R10: PartialRequest, R11: PartialRequest, R12: PartialRequest, R13: PartialRequest, R14: PartialRequest, R15: PartialRequest, R16: PartialRequest {
    return FunctionCall(inputs: [inputs.0, inputs.1, inputs.2, inputs.3, inputs.4, inputs.5, inputs.6, inputs.7, inputs.8, inputs.9, inputs.10, inputs.11, inputs.12, inputs.13, inputs.14, inputs.15]) {
        try function(inputs.0.fulfill(with: $0, and: $1), inputs.1.fulfill(with: $0, and: $1), inputs.2.fulfill(with: $0, and: $1), inputs.3.fulfill(with: $0, and: $1), inputs.4.fulfill(with: $0, and: $1), inputs.5.fulfill(with: $0, and: $1), inputs.6.fulfill(with: $0, and: $1), inputs.7.fulfill(with: $0, and: $1), inputs.8.fulfill(with: $0, and: $1), inputs.9.fulfill(with: $0, and: $1), inputs.10.fulfill(with: $0, and: $1), inputs.11.fulfill(with: $0, and: $1), inputs.12.fulfill(with: $0, and: $1), inputs.13.fulfill(with: $0, and: $1), inputs.14.fulfill(with: $0, and: $1), inputs.15.fulfill(with: $0, and: $1))
    }
}

public func ^ <Result, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17>(function: @escaping (R1.Result, R2.Result, R3.Result, R4.Result, R5.Result, R6.Result, R7.Result, R8.Result, R9.Result, R10.Result, R11.Result, R12.Result, R13.Result, R14.Result, R15.Result, R16.Result, R17.Result) throws -> Result, inputs: (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17)) -> FunctionCall<Result> where R1: PartialRequest, R2: PartialRequest, R3: PartialRequest, R4: PartialRequest, R5: PartialRequest, R6: PartialRequest, R7: PartialRequest, R8: PartialRequest, R9: PartialRequest, R10: PartialRequest, R11: PartialRequest, R12: PartialRequest, R13: PartialRequest, R14: PartialRequest, R15: PartialRequest, R16: PartialRequest, R17: PartialRequest {
    return FunctionCall(inputs: [inputs.0, inputs.1, inputs.2, inputs.3, inputs.4, inputs.5, inputs.6, inputs.7, inputs.8, inputs.9, inputs.10, inputs.11, inputs.12, inputs.13, inputs.14, inputs.15, inputs.16]) {
        try function(inputs.0.fulfill(with: $0, and: $1), inputs.1.fulfill(with: $0, and: $1), inputs.2.fulfill(with: $0, and: $1), inputs.3.fulfill(with: $0, and: $1), inputs.4.fulfill(with: $0, and: $1), inputs.5.fulfill(with: $0, and: $1), inputs.6.fulfill(with: $0, and: $1), inputs.7.fulfill(with: $0, and: $1), inputs.8.fulfill(with: $0, and: $1), inputs.9.fulfill(with: $0, and: $1), inputs.10.fulfill(with: $0, and: $1), inputs.11.fulfill(with: $0, and: $1), inputs.12.fulfill(with: $0, and: $1), inputs.13.fulfill(with: $0, and: $1), inputs.14.fulfill(with: $0, and: $1), inputs.15.fulfill(with: $0, and: $1), inputs.16.fulfill(with: $0, and: $1))
    }
}

public func ^ <Result, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18>(function: @escaping (R1.Result, R2.Result, R3.Result, R4.Result, R5.Result, R6.Result, R7.Result, R8.Result, R9.Result, R10.Result, R11.Result, R12.Result, R13.Result, R14.Result, R15.Result, R16.Result, R17.Result, R18.Result) throws -> Result, inputs: (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18)) -> FunctionCall<Result> where R1: PartialRequest, R2: PartialRequest, R3: PartialRequest, R4: PartialRequest, R5: PartialRequest, R6: PartialRequest, R7: PartialRequest, R8: PartialRequest, R9: PartialRequest, R10: PartialRequest, R11: PartialRequest, R12: PartialRequest, R13: PartialRequest, R14: PartialRequest, R15: PartialRequest, R16: PartialRequest, R17: PartialRequest, R18: PartialRequest {
    return FunctionCall(inputs: [inputs.0, inputs.1, inputs.2, inputs.3, inputs.4, inputs.5, inputs.6, inputs.7, inputs.8, inputs.9, inputs.10, inputs.11, inputs.12, inputs.13, inputs.14, inputs.15, inputs.16, inputs.17]) {
        try function(inputs.0.fulfill(with: $0, and: $1), inputs.1.fulfill(with: $0, and: $1), inputs.2.fulfill(with: $0, and: $1), inputs.3.fulfill(with: $0, and: $1), inputs.4.fulfill(with: $0, and: $1), inputs.5.fulfill(with: $0, and: $1), inputs.6.fulfill(with: $0, and: $1), inputs.7.fulfill(with: $0, and: $1), inputs.8.fulfill(with: $0, and: $1), inputs.9.fulfill(with: $0, and: $1), inputs.10.fulfill(with: $0, and: $1), inputs.11.fulfill(with: $0, and: $1), inputs.12.fulfill(with: $0, and: $1), inputs.13.fulfill(with: $0, and: $1), inputs.14.fulfill(with: $0, and: $1), inputs.15.fulfill(with: $0, and: $1), inputs.16.fulfill(with: $0, and: $1), inputs.17.fulfill(with: $0, and: $1))
    }
}

public func ^ <Result, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19>(function: @escaping (R1.Result, R2.Result, R3.Result, R4.Result, R5.Result, R6.Result, R7.Result, R8.Result, R9.Result, R10.Result, R11.Result, R12.Result, R13.Result, R14.Result, R15.Result, R16.Result, R17.Result, R18.Result, R19.Result) throws -> Result, inputs: (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19)) -> FunctionCall<Result> where R1: PartialRequest, R2: PartialRequest, R3: PartialRequest, R4: PartialRequest, R5: PartialRequest, R6: PartialRequest, R7: PartialRequest, R8: PartialRequest, R9: PartialRequest, R10: PartialRequest, R11: PartialRequest, R12: PartialRequest, R13: PartialRequest, R14: PartialRequest, R15: PartialRequest, R16: PartialRequest, R17: PartialRequest, R18: PartialRequest, R19: PartialRequest {
    return FunctionCall(inputs: [inputs.0, inputs.1, inputs.2, inputs.3, inputs.4, inputs.5, inputs.6, inputs.7, inputs.8, inputs.9, inputs.10, inputs.11, inputs.12, inputs.13, inputs.14, inputs.15, inputs.16, inputs.17, inputs.18]) {
        try function(inputs.0.fulfill(with: $0, and: $1), inputs.1.fulfill(with: $0, and: $1), inputs.2.fulfill(with: $0, and: $1), inputs.3.fulfill(with: $0, and: $1), inputs.4.fulfill(with: $0, and: $1), inputs.5.fulfill(with: $0, and: $1), inputs.6.fulfill(with: $0, and: $1), inputs.7.fulfill(with: $0, and: $1), inputs.8.fulfill(with: $0, and: $1), inputs.9.fulfill(with: $0, and: $1), inputs.10.fulfill(with: $0, and: $1), inputs.11.fulfill(with: $0, and: $1), inputs.12.fulfill(with: $0, and: $1), inputs.13.fulfill(with: $0, and: $1), inputs.14.fulfill(with: $0, and: $1), inputs.15.fulfill(with: $0, and: $1), inputs.16.fulfill(with: $0, and: $1), inputs.17.fulfill(with: $0, and: $1), inputs.18.fulfill(with: $0, and: $1))
    }
}

public func ^ <Result, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19, R20>(function: @escaping (R1.Result, R2.Result, R3.Result, R4.Result, R5.Result, R6.Result, R7.Result, R8.Result, R9.Result, R10.Result, R11.Result, R12.Result, R13.Result, R14.Result, R15.Result, R16.Result, R17.Result, R18.Result, R19.Result, R20.Result) throws -> Result, inputs: (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19, R20)) -> FunctionCall<Result> where R1: PartialRequest, R2: PartialRequest, R3: PartialRequest, R4: PartialRequest, R5: PartialRequest, R6: PartialRequest, R7: PartialRequest, R8: PartialRequest, R9: PartialRequest, R10: PartialRequest, R11: PartialRequest, R12: PartialRequest, R13: PartialRequest, R14: PartialRequest, R15: PartialRequest, R16: PartialRequest, R17: PartialRequest, R18: PartialRequest, R19: PartialRequest, R20: PartialRequest {
    return FunctionCall(inputs: [inputs.0, inputs.1, inputs.2, inputs.3, inputs.4, inputs.5, inputs.6, inputs.7, inputs.8, inputs.9, inputs.10, inputs.11, inputs.12, inputs.13, inputs.14, inputs.15, inputs.16, inputs.17, inputs.18, inputs.19]) {
        try function(inputs.0.fulfill(with: $0, and: $1), inputs.1.fulfill(with: $0, and: $1), inputs.2.fulfill(with: $0, and: $1), inputs.3.fulfill(with: $0, and: $1), inputs.4.fulfill(with: $0, and: $1), inputs.5.fulfill(with: $0, and: $1), inputs.6.fulfill(with: $0, and: $1), inputs.7.fulfill(with: $0, and: $1), inputs.8.fulfill(with: $0, and: $1), inputs.9.fulfill(with: $0, and: $1), inputs.10.fulfill(with: $0, and: $1), inputs.11.fulfill(with: $0, and: $1), inputs.12.fulfill(with: $0, and: $1), inputs.13.fulfill(with: $0, and: $1), inputs.14.fulfill(with: $0, and: $1), inputs.15.fulfill(with: $0, and: $1), inputs.16.fulfill(with: $0, and: $1), inputs.17.fulfill(with: $0, and: $1), inputs.18.fulfill(with: $0, and: $1), inputs.19.fulfill(with: $0, and: $1))
    }
}

// sourcery:end
