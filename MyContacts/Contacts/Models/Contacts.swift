//
//  Contacts.swift
//  MyContacts
//
//  Created by jithin on 24/07/18.
//  Copyright © 2018 Jithin. All rights reserved.
//

import Foundation
import Firebase


struct Contact {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let phone: String
    let country: String
    
    init(id: String, firstName: String, lastName: String, email: String, phone: String, country: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phone = phone
        self.country = country
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let id = value[FirebaseKeys.id] as? String,
            let firstName = value[FirebaseKeys.firstName] as? String,
            let lastName = value[FirebaseKeys.lastName] as? String,
            let email = value[FirebaseKeys.email] as? String,
            let phone = value[FirebaseKeys.phone] as? String,
            let country = value[FirebaseKeys.country] as? String
            else {
                return nil
        }
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phone = phone
        self.country = country
    }
    
    func asAny() -> Any {
        return [
            FirebaseKeys.id: id,
            FirebaseKeys.firstName: firstName,
            FirebaseKeys.lastName: lastName,
            FirebaseKeys.email: email,
            FirebaseKeys.phone: phone,
            FirebaseKeys.country: country
        ]
    }
}
