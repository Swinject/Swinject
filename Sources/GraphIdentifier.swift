//
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//

/// Unique identifier of an object graph during a resolution process.
public struct GraphIdentifier: Identifiable {
    public let id = UUID()
}

extension GraphIdentifier: Equatable, Hashable {}
