//
//  ContactsViewController.swift
//  MyContacts
//
//  Created by jithin on 24/07/18.
//  Copyright © 2018 Jithin. All rights reserved.
//

import UIKit

class ContactsViewController: BaseViewController {
    
    @IBOutlet weak var contactsTableView: UITableView!

    var contacts: [Contact] = []
    var filteredContacts: [Contact] = []
    let searchController = UISearchController(searchResultsController: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
        addListeners()
        

        DispatchQueue.global(qos: .background).async {
            ContactsController.fetchCountriesList()
        }
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
    
    fileprivate func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    fileprivate func filterContactForSearchText( _ text: String) {
        filteredContacts = contacts.filter({ (contact) -> Bool in
            return contact.name.lowercased().contains(text.lowercased())
        })
        contactsTableView.reloadData()
    }
    
    fileprivate func isSearchActive() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    fileprivate func showDetailWithContact(_ contact: Contact) {
        
        let contactDetailVC = storyboard?.instantiateViewController(withIdentifier: ViewcontrollerIds.contactDetail) as! ContactDetailViewController
        contactDetailVC.contact = contact
        self.navigationController?.pushViewController(contactDetailVC, animated: true)
    }
}

extension ContactsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearchActive() {
            return filteredContacts.count
        }
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.contactListCell, for: indexPath) as! ContactListCell
        
        let contact: Contact
        if isSearchActive(){
            contact = filteredContacts[indexPath.row]
        }
        else{
            contact = contacts[indexPath.row]
        }
        cell.nameLabel.text = contact.name
        cell.phoneLabel.text = contact.phone
        cell.profileImageView.setImage(string: contact.name, color: .green)
        
        return cell
    }
}

extension ContactsViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Logger.log("cell selected with contact \(contacts[indexPath.row])")
        let contact: Contact
        if isSearchActive(){
            contact = filteredContacts[indexPath.row]
        }
        else{
            contact = contacts[indexPath.row]
        }
        showDetailWithContact(contact)
    }
}

extension ContactsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text else { return }
        filterContactForSearchText(text)
    }
    
    
}



