//
//  UserShowViewController.swift
//  BrewMail
//
//  Created by Chase Lancaster on 8/3/20.
//  Copyright © 2020 Chase Lancaster. All rights reserved.
//

import Firebase
import FirebaseFirestoreSwift
import Foundation
import UIKit

class UserShowViewController: UIViewController {
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        
        
    }
    
    @objc func logoutTapped() {
        
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            print("User logged out")
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
    }
    
}
