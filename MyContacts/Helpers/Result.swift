//
//  Result.swift
//  MyContacts
//
//  Created by Denny Mathew on 24/07/18.
//  Copyright © 2018 Jithin. All rights reserved.
//

import Foundation

enum Result<T, E: Error> {
    case Success(T)
    case Failure(E)
}
