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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addListeners()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        FirebaseManager.shared.removeListeners()
    }
    
    fileprivate func addListeners (){
        
        FirebaseManager.shared.contactAdded { (result) in
            switch result {
            case .Success(let contact):
                self.contacts.append(contact)
                
//                let index = IndexPath(row: self.contacts.count - 1, section: 0)
//                self.contactsTableView.insertRows(at: [index], with: .automatic)
                
            case .Failure(_): break
            }
        }
        
        FirebaseManager.shared.contactUpdated { (result) in
            switch result {
            case .Success(let contact):
                
                guard let index = self.contacts.index(where: { $0.id == contact.id }) else { return }
                self.contacts[index] = contact
//                let path = IndexPath(row: index, section: 0)
//                self.contactsTableView.reloadRows(at: [path], with: .automatic)
                
            case .Failure(_): break
            }
        }
        
        FirebaseManager.shared.contactDeleted { (result) in
            switch result {
            case .Success(let contact):
                
                guard let index = self.contacts.index(where: { $0.id == contact.id }) else { return }
                self.contacts.remove(at: index)
//                let path = IndexPath(row: index, section: 0)
//                self.contactsTableView.deleteRows(at: [path], with: .automatic)
                
            case .Failure(_): break
            }
        }
    }

}

extension ContactsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.contactListCell, for: indexPath)
        cell.textLabel?.text = contacts[indexPath.row].firstName
        cell.detailTextLabel?.text = contacts[indexPath.row].phone
        
        return cell
    }
}
