//
//  RegisterViewController.swift
//  BrewMail
//
//  Created by Chase Lancaster on 5/28/20.
//  Copyright © 2020 Chase Lancaster. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var firstNameTextfield: UITextField!
    @IBOutlet var lastNameTextfield: UITextField!
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        
        emailTextfield.delegate = self
        passwordTextfield.delegate = self
        
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        
        if let email = emailTextfield.text, let password = passwordTextfield.text, let firstName = firstNameTextfield.text, let lastName = lastNameTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e, "<-- Error in Register Auth")
                } else {
                    // Navigate to the main search field
                    print("User successfully registered")
                    guard let uid = Auth.auth().currentUser?.uid else { return }
                    self.db.collection("users").document("\(uid)").setData([
                        "firstName":"\(firstName)",
                        "lastName":"\(lastName)",
                        "accountEmail":"\(email)"
                        ])
                    { (err) in
                        if err != nil {
                            print("Error adding uid to userID")
                        } else {
                            print("userID successfully added to db")
                        }
                    }
                    print(uid, "<--uid")
                    self.performSegue(withIdentifier: Constants.registerSegue, sender: self)
                }
            }
        }
        
    }
    
    // MARK: - Keyboard Related Code
    
    // Hiding keyboard when tapped outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // Hides keyboard when return button is tapped
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
