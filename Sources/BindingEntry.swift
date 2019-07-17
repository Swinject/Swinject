//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// sourcery: AutoMockable
protocol AnyMakerEntry: SwinjectEntry {
    var key: AnyMakerKey { get }
    var maker: AnyInstanceMaker { get }
}

// TODO: Make this internal
public struct MakerEntry<Type>: AnyMakerEntry {
    let key: AnyMakerKey
    let maker: AnyInstanceMaker
}
