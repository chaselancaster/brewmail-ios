//
//  RegisterViewController.swift
//  BrewMail
//
//  Created by Chase Lancaster on 5/28/20.
//  Copyright © 2020 Chase Lancaster. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: Any) {
        
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                } else {
                    //Navigate to ViewController
                }
            }
        }
        
        
    }
}
