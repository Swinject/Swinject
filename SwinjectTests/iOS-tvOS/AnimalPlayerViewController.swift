//
//  AnimalPlayerViewController.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 11/1/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import AVKit

internal class AnimalPlayerViewController: AVPlayerViewController {
    internal var animal: AnimalType?
    
    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    internal func hasAnimal(named name: String) -> Bool {
        return animal?.name == name
    }
}
