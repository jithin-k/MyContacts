//
//  ContactDetailViewController.swift
//  MyContacts
//
//  Created by jithin on 26/07/18.
//  Copyright © 2018 jithin. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

    var contact: Contact?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        setContactData()
    }

    fileprivate func setContactData() {
        
        guard let contact = contact else { return }
        
        nameLabel.text = contact.name
        phoneLabel.text = contact.phone
        emailLabel.text = contact.email
        countryLabel.text = contact.country
    }
}
