//
//  Box.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 11/27/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Foundation

public final class Box<T> {
    public let value: T

    public init(_ value: T) {
        self.value = value
    }
}