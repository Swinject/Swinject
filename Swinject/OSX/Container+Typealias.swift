//
//  Container+Typealias.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 8/1/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import AppKit

extension Container {
    // Actually it should be NSViewController or NSWindowController
    // See the reference of NSStoryboard.instantiateInitialController method.
    public typealias Controller = AnyObject
}
