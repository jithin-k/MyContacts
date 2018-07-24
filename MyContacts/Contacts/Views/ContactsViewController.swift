//
//  ContactsViewController.swift
//  MyContacts
//
//  Created by jithin on 24/07/18.
//  Copyright © 2018 Jithin. All rights reserved.
//

import UIKit

class ContactsViewController: BaseViewController {
    
    var contacts: [Contact] = []
    @IBOutlet weak var contactsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addListeners()
    }
    
    fileprivate func addListeners (){
        
        FirebaseManager.shared.contactAdded { (result) in
            switch result {
            case .Success(let contact):
                self.contacts.append(contact)
                
                let index = IndexPath(row: self.contacts.count - 1, section: 0)
                self.contactsTableView.insertRows(at: [index], with: .automatic)
                
            case .Failure(_): break
            }
        }
        
        FirebaseManager.shared.contactUpdated { (result) in
            switch result {
            case .Success(let contact):
                
                guard let index = self.contacts.index(where: { $0.id == contact.id }) else { return }
                self.contacts[index] = contact
                let path = IndexPath(row: index, section: 0)
                self.contactsTableView.reloadRows(at: [path], with: .automatic)
                
            case .Failure(_): break
            }
        }
        
        FirebaseManager.shared.contactDeleted { (result) in
            switch result {
            case .Success(let contact):
                
                guard let index = self.contacts.index(where: { $0.id == contact.id }) else { return }
                self.contacts.remove(at: index)
                let path = IndexPath(row: index, section: 0)
                self.contactsTableView.deleteRows(at: [path], with: .automatic)
                
            case .Failure(_): break
            }
        }
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        
        let addContactVC = storyboard?.instantiateViewController(withIdentifier: ViewcontrollerIds.addContactVC) as! AddContactViewController
        self.navigationController?.pushViewController(addContactVC, animated: true)
    }
    
}

extension ContactsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.contactListCell, for: indexPath) as! ContactListCell
        cell.nameLabel.text = contacts[indexPath.row].name
        cell.phoneLabel.text = contacts[indexPath.row].phone
        
        return cell
    }
}
