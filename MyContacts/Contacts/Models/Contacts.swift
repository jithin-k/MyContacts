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
    let name: String
    let email: String
    let phone: String
    let country: String
    
    init(id: String, name: String, email: String, phone: String, country: String) {
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
        self.country = country
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let id = value[FirebaseKeys.id] as? String,
            let name = value[FirebaseKeys.name] as? String,
            let email = value[FirebaseKeys.email] as? String,
            let phone = value[FirebaseKeys.phone] as? String,
            let country = value[FirebaseKeys.country] as? String
            else {
                return nil
        }
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
        self.country = country
    }
    
    func asAny() -> Any {
        return [
            FirebaseKeys.id: id,
            FirebaseKeys.name: name,
            FirebaseKeys.email: email,
            FirebaseKeys.phone: phone,
            FirebaseKeys.country: country
        ]
    }
}
