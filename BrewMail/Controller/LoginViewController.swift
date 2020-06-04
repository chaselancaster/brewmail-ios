//
//  LoginViewController.swift
//  BrewMail
//
//  Created by Chase Lancaster on 6/1/20.
//  Copyright © 2020 Chase Lancaster. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        
        emailTextfield.delegate = self
        passwordTextfield.delegate = self
        
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                if let e = error {
                    print(e, "<-- Error in Login")
                } else {
                    print("Login successful")
                    self?.performSegue(withIdentifier: Constants.loginSegue, sender: self)
                }
            }
        }
        
    }
    
    // MARK: - Keyboard Related Code
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

