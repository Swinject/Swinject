//
//  ResolverError.swift
//  Swinject-iOS
//
//  Created by Evgeny Kalashnikov on 15.05.2018.
//  Copyright © 2018 Swinject Contributors. All rights reserved.
//

enum ResolverError<Service>: Error {
    case cantResolve(type: Service.Type, name: String?)
}
