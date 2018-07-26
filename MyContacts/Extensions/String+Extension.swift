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
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isValidPhoneNumber() -> Bool {
        let phoneRegEx = "^[0-9]{6,14}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        return phoneTest.evaluate(with: self)
    }
}
