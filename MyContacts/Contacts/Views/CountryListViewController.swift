//
//  CountryListViewController.swift
//  MyContacts
//
//  Created by jithin on 26/07/18.
//  Copyright © 2018 jithin. All rights reserved.
//

import UIKit

protocol CountrySelectionDelegate {
    func didSelectCountry(_ country: Country)
}

class CountryListViewController: UIViewController {

    @IBOutlet weak var countryListTableView: UITableView!
    var countries: [Country] = []
    var delegate: CountrySelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
}

extension CountryListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.countryList, for: indexPath)
        cell.textLabel?.text = countries[indexPath.row].name
        return cell
    }
}

extension CountryListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let country = countries[indexPath.row]
        DispatchQueue.main.async {
            self.navigationController?.dismiss(animated: true) {
                self.delegate?.didSelectCountry(country)
            }
        }

    }
}
