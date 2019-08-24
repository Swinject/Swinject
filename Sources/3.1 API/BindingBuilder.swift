//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

public protocol AnyBindingBuilder: SwinjectEntry {
    func makeBinding() -> Binding
}
