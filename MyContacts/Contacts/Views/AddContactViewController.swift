//
//  AddContactViewController.swift
//  MyContacts
//
//  Created by Denny Mathew on 25/07/18.
//  Copyright © 2018 Jithin. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var countryTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func saveContactTapped(_ sender: UIButton) {
        
        guard let name = nameTextField.text, let email = emailTextField.text, let phone = phoneTextField.text, let country = countryTextField.text else { return }
        
        let contact = Contact(id: UUID().uuidString, name: name, email: email, phone: phone, country: country)
        
        FirebaseManager.shared.saveContact(contact)
    }
}
