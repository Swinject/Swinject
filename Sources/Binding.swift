//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// sourcery: AutoMockable
public protocol Binding: SwinjectEntry {}

struct SimpleBinding: Binding {
    let key: AnyBindingKey
    let maker: AnyInstanceMaker
}
