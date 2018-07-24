//
//  FirebaseManager.swift
//  MyContacts
//
//  Created by Denny Mathew on 24/07/18.
//  Copyright © 2018 Jithin. All rights reserved.
//

import Foundation
import Firebase

class FirebaseManager {
    
    typealias ContactCompletion = (Result<Contact, APIError>) -> ()
    static let shared = FirebaseManager()
    
    fileprivate var rootRef: DatabaseReference!
    var newContactHandle: DatabaseHandle!
    var updateContactHandle: DatabaseHandle!
    var removeContactHandle: DatabaseHandle!

    private init() {
        rootRef = Database.database().reference(withPath: FirebaseRef.contacts)
    }
    
    func newContactAdded(completion: @escaping ContactCompletion) {
        newContactHandle = rootRef.observe(.childAdded) { (snapshot) in
            guard let newContact = Contact(snapshot: snapshot) else { return }
            
            completion(.Success(newContact))
        }
    }
    
    func contactUpdated(completion: @escaping ContactCompletion) {
        updateContactHandle = rootRef.observe(.childChanged, with: { (snapshot) in
            guard let newContact = Contact(snapshot: snapshot) else { return }
            
            completion(.Success(newContact))
        })
    }
    
    func contactDeleted(completion: @escaping ContactCompletion) {
        removeContactHandle = rootRef.observe(.childRemoved, with: { (snapshot) in
            guard let newContact = Contact(snapshot: snapshot) else { return }
            
            completion(.Success(newContact))
        })
    }
    
    func removeListeners() {
        self.rootRef.removeObserver(withHandle: newContactHandle)
        self.rootRef.removeObserver(withHandle: updateContactHandle)
        self.rootRef.removeObserver(withHandle: removeContactHandle)
    }
}
