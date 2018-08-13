//
//  BasicViewController.swift
//  Swinject
//
//  Created by Brian Radebaugh on 8/12/18.
//  Copyright © 2018 Swinject Contributors. All rights reserved.
//

import Swinject

/**
 Not actually a ViewController so it works with all test targets.
 The inits are to make this class look and feel like a ViewController.
 */
class BasicViewController {
    /**
     This is force unwrapped because this class will not work correctly if it is not resolved first.
     Since this class is resolved in all initializers then there is not reasonable way this will be nil
     (assuming it is registered correctly).
     */
    var food: Food!

    init(withCoder coder: Any) {
        ManualResolver.finishConstruction(me: self)
    }

    init(nilOrNibName: Any?) {
        ManualResolver.finishConstruction(me: self)
    }

    convenience init() {
        self.init(nilOrNibName: nil)
    }

    /**
     This is the function that will be called when registering the service,
     or during testing to inject a test double.
     */
    func inject(food: Food) {
        self.food = food
    }
}
