//
//  FirebaseManager.swift
//  MyContacts
//
//  Created by jithin on 24/07/18.
//  Copyright © 2018 jithin. All rights reserved.
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
    
    func saveContact(_ contact: Contact) {
        rootRef.child(contact.id).setValue(contact.asAny())
    }
    
    func contactAdded(completion: @escaping ContactCompletion) {
        newContactHandle = rootRef.observe(.childAdded) { (snapshot) in
            guard let contact = Contact(snapshot: snapshot) else { return }
            
            Logger.log("contact: \(contact)")
            completion(.Success(contact))
        }
    }
    
    func contactUpdated(completion: @escaping ContactCompletion) {
        updateContactHandle = rootRef.observe(.childChanged, with: { (snapshot) in
            guard let contact = Contact(snapshot: snapshot) else { return }
            
            Logger.log("contact: \(contact)")
            completion(.Success(contact))
        })
    }
    
    func contactDeleted(completion: @escaping ContactCompletion) {
        removeContactHandle = rootRef.observe(.childRemoved, with: { (snapshot) in
            guard let contact = Contact(snapshot: snapshot) else { return }
            
            Logger.log("contact: \(contact)")
            completion(.Success(contact))
        })
    }
    
    func removeListeners() {
        self.rootRef.removeObserver(withHandle: newContactHandle)
        self.rootRef.removeObserver(withHandle: updateContactHandle)
        self.rootRef.removeObserver(withHandle: removeContactHandle)
    }
}
