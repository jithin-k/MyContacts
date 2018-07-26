//
//  AddContactViewController.swift
//  MyContacts
//
//  Created by jithin on 25/07/18.
//  Copyright © 2018 jithin. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    var countries: [Country]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never
        guard let countries = ContactsController.countriesList() else { return }
        self.countries = countries
    }

    @IBAction func saveContactTapped(_ sender: UIButton) {
        
        guard let name = nameTextField.text, name.isNonEmpty(), let email = emailTextField.text, let phone = phoneTextField.text, let country = countryTextField.text, country.isNonEmpty() else { return }
        
        let contact = Contact(id: UUID().uuidString, name: name, email: email, phone: phone, country: country)
        
        FirebaseManager.shared.saveContact(contact)
        self.navigationController?.popViewController(animated: true)
    }
    
    fileprivate func presentCountryListVC() {
        
        guard let countries = self.countries else { return }
        
        let countryListVC = storyboard?.instantiateViewController(withIdentifier: ViewcontrollerIds.countryList) as! CountryListViewController
        countryListVC.countries = countries
        countryListVC.delegate = self
        let nav = UINavigationController(rootViewController: countryListVC)
        self.navigationController?.present(nav, animated: true, completion: nil)
    }
}

extension AddContactViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == countryTextField {
            presentCountryListVC()
        }
    }
}

extension AddContactViewController: CountrySelectionDelegate {
    
    func didSelectCountry(_ country: Country) {
        
        countryTextField.text = country.name
    }
}
