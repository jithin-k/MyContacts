//
//  Errors.swift
//  MyContacts
//
//  Created by jithin on 24/07/18.
//  Copyright © 2018 Jithin. All rights reserved.
//

import Foundation

enum APIError: Error{
    case invalidRequest
    case noInternet
    case invalidResponse
    case error(String)
}

extension APIError: LocalizedError{
    
    public var errorDescription: String?{
        
        switch self {
            
        case .invalidRequest:
            return "Invalid request"
            
        case .invalidResponse:
            return "Invalid response from server"
            
        case .noInternet:
            return "No internet. Please check your connection and try again"
            
        case .error(let message):
            return message
            
        }
    }
}
