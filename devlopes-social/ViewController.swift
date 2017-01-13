//
//  ViewController.swift
//  devlopes-social
//
//  Created by Marissa Dietz on 1/3/17.
//  Copyright © 2017 Carter Apps. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookButtonTapped(_ sender: AnyObject) {
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("Brad Error Unable to Authenticate with Facebook = \(error)")
            } else if result?.isCancelled == true {
                print("User Canceled Facebook authentication")
            } else {
                print("Brad Authenticated with facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
            
        }
        
    }
    
    @IBOutlet weak var emailTextField: AdvancedField!
    
    @IBOutlet weak var passwordField: AdvancedField!
    
    @IBAction func signInButtonPressed(_ sender: AnyObject) {
        if let email = emailTextField.text, let pwd = passwordField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("Brad: Email Sign in Success")
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("Error creating user \(error)")
                        } else {
                            print("Brad: User successfully created with email on Firebase")
                        }
                    })
                }
            })
        }
    }
    
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("Brad Unable to authenticate error = \(error)")
            } else {
                print("Brad Successfully authenticated with Firebase")
            }
        })
    }

}

