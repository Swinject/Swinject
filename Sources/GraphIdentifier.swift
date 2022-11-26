//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

// no universal UUID impl on Linux

#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)
import Foundation

/// Unique identifier of an object graph during a resolution process.
public struct GraphIdentifier: Identifiable {
    public let id = UUID()
}
#else
/// Unique identifier of an object graph during a resolution process.
public struct GraphIdentifier: Identifiable {
    public let id = UInt.random(in: 0..<UInt.max)
}
#endif

extension GraphIdentifier: Equatable, Hashable {}
