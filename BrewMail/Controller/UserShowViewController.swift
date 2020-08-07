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
    
    override func viewDidLoad() {
        
        title = "User"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        
    }
    
    @objc func logoutTapped() {
        
        print("Logout tapped hit")
        
    }
    
}
