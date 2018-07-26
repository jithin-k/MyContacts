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
        
        var initials = String()
        let words = components(separatedBy: " ")
        
        for item in words{
            guard initials.count < 2, let first = item.first else { return initials.uppercased() }
            initials.append(first)
        }
        return initials.uppercased()
    }
    
    func isNonEmpty() -> Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).count > 0
    }
}
