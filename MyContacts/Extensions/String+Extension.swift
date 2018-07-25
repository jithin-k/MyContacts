//
//  String+Extension.swift
//  MyContacts
//
//  Created by Denny Mathew on 25/07/18.
//  Copyright © 2018 Jithin. All rights reserved.
//

import Foundation

extension String {
    
    public var initials: String {
        
        var finalString = String()
        var words = components(separatedBy: .whitespacesAndNewlines)
        
        if let firstCharacter = words.first?.first {
            finalString.append(String(firstCharacter))
            words.removeFirst()
        }
        return finalString.uppercased()
    }
}
