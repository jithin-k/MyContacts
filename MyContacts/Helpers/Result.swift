//
//  Result.swift
//  MyContacts
//
//  Created by jithin on 24/07/18.
//  Copyright © 2018 jithin. All rights reserved.
//

import Foundation

enum Result<T, E: Error> {
    case Success(T)
    case Failure(E)
}
