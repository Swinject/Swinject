//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

/// Unique identifier of an object graph during a resolution process.
public final class GraphIdentifier {}

extension GraphIdentifier: Equatable, Hashable {
    public static func == (lhs: GraphIdentifier, rhs: GraphIdentifier) -> Bool {
        return lhs === rhs
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self).hashValue)
    }
}
