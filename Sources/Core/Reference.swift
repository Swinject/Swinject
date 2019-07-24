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

struct WeakReference: Reference {
    private weak var object: AnyObject?
    var value: Any? {
        guard let object = object else { return nil }
        return object
    }

    struct Maker: ReferenceMaker {
        func makeReference(for value: Any) -> Reference {
            #if os(Linux)
                return WeakReference(object: value as? AnyObject)
            #else
                return WeakReference(object: value as AnyObject)
            #endif
        }
    }
}

public let strongRef: ReferenceMaker = StrongReference.Maker()
public let weakRef: ReferenceMaker = WeakReference.Maker()
