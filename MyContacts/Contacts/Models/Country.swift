//
//  Country.swift
//  MyContacts
//
//  Created by jithin on 24/07/18.
//  Copyright © 2018 Jithin. All rights reserved.
//

import Foundation

struct Country: Decodable {
    let name: String
    let countryCode: String
    let region: String
    
    private enum CodingKeys: String, CodingKey{
        case name
        case countryCode = "alpha3Code"
        case region
    }
}
