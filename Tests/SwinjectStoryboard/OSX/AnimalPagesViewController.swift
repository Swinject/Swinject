//
//  AnimalPagesViewController.swift
//  Swinject
//
//  Created by Jakub Vaňo on 27/10/16.
//  Copyright © 2016 Swinject Contributors. All rights reserved.
//

import AppKit
import Swinject

internal class AnimalPagesViewController: NSPageController {
    let animalPage: AnimalViewController

    required init?(coder aDecoder: NSCoder) {
        animalPage = NSStoryboard(
            name: "Pages",
            bundle: NSBundle(forClass: AnimalPagesViewController.self)
        ).instantiateControllerWithIdentifier("AnimalPage") as! AnimalViewController

        super.init(coder: aDecoder)
    }
}
