//
//  Cat.Identifier.swift
//  Swinject
//
//  Created by Benjamin Lavialle on 18/12/2020.
//

import Foundation
import Swinject

extension Cat: Identifiable {

    typealias Identifier = SwinjectName

    enum SwinjectName: String, TypeIdentifier {
        case firstCat = "My First Cat"
        case secondCat = "My Second Cat"
    }

}
