//
//  AnimalViewController.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 7/31/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import UIKit

internal class AnimalViewController: UIViewController {
    internal var animal: AnimalType?
    
    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    internal func hasAnimal(named name: String) -> Bool {
        return animal?.name == name
    }
}
