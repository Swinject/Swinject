//
//  ObjectScope.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/24/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

public enum ObjectScope {
    case None
    case Graph
    case Container
    case Hierarchy

    // TODO: Add more scope cases.
    // case WeakContainer
    // case Thread
}
