//
//  Box.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 11/27/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Foundation

internal final class Box<T> {
    internal let value: T

    internal init(_ value: T) {
        self.value = value
    }
}
