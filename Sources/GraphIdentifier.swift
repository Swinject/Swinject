//
//  GraphIdentifier.swift
//  Swinject
//
//  Created by Jakub Vaňo on 08/03/2018.
//  Copyright © 2018 Swinject Contributors. All rights reserved.
//

/// Unique identifier of an object graph during a resolution process.
public final class GraphIdentifier {}

extension GraphIdentifier: Equatable, Hashable {
    public static func == (lhs: GraphIdentifier, rhs: GraphIdentifier) -> Bool {
        return lhs === rhs
    }

    public var hashValue: Int { return ObjectIdentifier(self).hashValue }
}
