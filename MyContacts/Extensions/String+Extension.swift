//
//  String+Extension.swift
//  MyContacts
//
//  Created by jithin on 25/07/18.
//  Copyright © 2018 jithin. All rights reserved.
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
    
    func isNonEmpty() -> Bool {
        
        return self.trimmingCharacters(in: .whitespacesAndNewlines).count > 0
    }
}
