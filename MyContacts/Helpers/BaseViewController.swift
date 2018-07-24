//
//  BaseViewController.swift
//  MyContacts
//
//  Created by jithin on 24/07/18.
//  Copyright © 2018 Jithin. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    func showAlert(title: String = Constants.appName, _ message: String, actions: [UIAlertAction]?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let actions = actions{
            for action in actions {
                alertController.addAction(action)
            }
        }
        else {
            let defaultAction = UIAlertAction(title: Constants.ok, style: .default, handler: nil)
            alertController.addAction(defaultAction)
        }
        present(alertController, animated: true, completion: nil)
    }
}
