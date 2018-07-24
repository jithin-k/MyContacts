//
//  AppDelegate.swift
//  MyContacts
//
//  Created by Jithin on 24/07/18.
//  Copyright © 2018 Jithin. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true
        
        return true
    }

}

