//
//  AddContactViewController.swift
//  MyContacts
//
//  Created by jithin on 25/07/18.
//  Copyright © 2018 jithin. All rights reserved.
//

import UIKit

protocol EditContactDelegate {
    func didEditContact(_ contact: Contact)
}

enum UIState {
    case addContact
    case editContact
}
class AddContactViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var addContactButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    var activeTextField: UITextField?
    
    var countries: [Country]?
    var uiState: UIState = .addContact
    var contact: Contact?
    var delegate: EditContactDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never
        guard let countries = ContactsController.countriesList() else { return }
        self.countries = countries
        navigationItem.title = Constants.newContact
        nameTextField.becomeFirstResponder()
        if uiState == .editContact{
            navigationItem.title = Constants.editContact
            addCancelButton()
            setContactDetails()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
//    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            if self.view.frame.origin.y == 0{
//                self.view.frame.origin.y -= keyboardSize.height
//            }
//        }
//    }
//
//    @objc func keyboardWillHide(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            if self.view.frame.origin.y != 0{
//                self.view.frame.origin.y += keyboardSize.height
//            }
//        }
//    }
    
    fileprivate func addCancelButton(){
        let cancelButton = UIBarButtonItem(title: Constants.cancel, style: .plain, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = cancelButton
    }
    
    @objc func dismissVC() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setContactDetails() {
        guard let contact = contact else { return }
        nameTextField.text = contact.name
        phoneTextField.text = contact.phone
        emailTextField.text = contact.email
        countryTextField.text = contact.country
        profileImageView.setImage(string: contact.name, color: .gray, fontSize: 32)
    }
    
    @IBAction func saveContactTapped(_ sender: UIButton) {
        
        guard let name = nameTextField.text, let email = emailTextField.text, let phone = phoneTextField.text, let country = countryTextField.text else { return }
        
        if uiState == .addContact{
            let newContact = Contact(id: UUID().uuidString, name: name, email: email, phone: phone, country: country)
            FirebaseManager.shared.saveContact(newContact)
        }
        else if let savedContact = self.contact{
            let updatedContact = Contact(id: savedContact.id, name: name, email: email, phone: phone, country: country)
            FirebaseManager.shared.saveContact(updatedContact)
            delegate?.didEditContact(updatedContact)
            self.navigationController?.dismiss(animated: true, completion: {
                
            })
        }
        
        if uiState == .addContact {
            self.navigationController?.popViewController(animated: true)
        }
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
        if textField == countryTextField {
            presentCountryListVC()
        }
    }
    
    fileprivate func validateFields() -> Bool {
        guard let name = nameTextField.text, name.isNonEmpty(), let email = emailTextField.text, email.isValidEmail(), let phone = phoneTextField.text, phone.isValidPhoneNumber(), let country = countryTextField.text, country.isNonEmpty() else { return false }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
        if textField == nameTextField{
            phoneTextField.becomeFirstResponder()
        }
        else if textField == phoneTextField{
            emailTextField.becomeFirstResponder()
        }
        else if textField == emailTextField{
            countryTextField.becomeFirstResponder()
        }
        if validateFields(){
            addContactButton.isEnabled = true
        }
        else{
            addContactButton.isEnabled = false
        }
    }
}

extension AddContactViewController: CountrySelectionDelegate {
    
    func didSelectCountry(_ country: Country) {
        
        countryTextField.text = country.name
        
        if validateFields(){
            addContactButton.isEnabled = true
        }
        else{
            addContactButton.isEnabled = false
        }
    }
}
