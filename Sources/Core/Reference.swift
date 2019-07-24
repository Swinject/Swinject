//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// sourcery: AutoMockable
public protocol Reference {
    var value: Any? { get }
}

// sourcery: AutoMockable
public protocol ReferenceMaker {
    func makeReference(for value: Any) -> Reference
}

struct StrongReference: Reference {
    let value: Any?

    struct Maker: ReferenceMaker {
        func makeReference(for value: Any) -> Reference {
            StrongReference(value: value)
        }
    }
}

public let strongRef: ReferenceMaker = StrongReference.Maker()
