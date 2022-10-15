//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

#if os(iOS) || os(macOS)
/// Unique identifier of an object graph during a resolution process.
public struct GraphIdentifier: Identifiable {
    public let id = UUID()
}

extension GraphIdentifier: Equatable, Hashable {}
#else
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
#endif
