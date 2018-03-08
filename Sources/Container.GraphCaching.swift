//
//  Container.GraphCaching.swift
//  Swinject
//
//  Created by Jakub Vaňo on 08/03/2018.
//  Copyright © 2018 Swinject Contributors. All rights reserved.
//

extension Container {
    func restoreObjectGraph(_ identifier: GraphIdentifier) {
        currentObjectGraph = identifier
    }
}
