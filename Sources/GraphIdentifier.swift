//
//  GraphIdentifier.swift
//  Swinject
//
//  Created by Jakub Vaňo on 08/03/2018.
//  Copyright © 2018 Swinject Contributors. All rights reserved.
//

/// Unique identifier of an object graph during a resolution process.
public struct GraphIdentifier {
    private let uuid = UUID()
}

extension GraphIdentifier: Equatable, Hashable {
    public static func == (lhs: GraphIdentifier, rhs: GraphIdentifier) -> Bool {
        return lhs.uuid == rhs.uuid
    }

    public var hashValue: Int { return uuid.hashValue }
}
