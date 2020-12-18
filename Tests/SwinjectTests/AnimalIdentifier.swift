//
//  Animal.TypeIdentifier.swift
//  Swinject
//
//  Created by Benjamin Lavialle on 18/12/2020.
//

import Foundation
import Swinject

internal enum AnimalIdentifier: String, DedicatedIdentifier {

    typealias IdentifiedType = Animal

    case myCat = "My Cat"
    case myOtherCat = "My Other Cat"
}
