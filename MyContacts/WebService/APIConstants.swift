//
//  APIConstants.swift
//  MyContacts
//
//  Created by jithin on 24/07/18.
//  Copyright © 2018 jithin. All rights reserved.
//

import Foundation

struct APIConstants {
    static let baseUrl = "https://restcountries.eu/rest/v1/"
    static let contentType = "Content-Type"
    static let json = "application/json"
}

enum APIEndPoint: String{
    case allCountries = "all"
}
