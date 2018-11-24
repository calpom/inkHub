//
//  SignUpVC.swift
//  inkHub
//
//  Created by Kaleb  on 11/24/18.
//  Copyright © 2018 KMTech. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class SignUpVC: UIViewController {

    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var emailAdressField: FancyField!
    @IBOutlet weak var usernameField: FancyField!
    @IBOutlet weak var passwordField: FancyField!
    @IBOutlet weak var passwordField2: FancyField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        warningLabel.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        warningLabel.isHidden = true
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        /*
        // THIS IS THE METHOD THAT CREATES USER (USE IT FOR ABOVE TODO)
        Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
            if error != nil {
                
                // TODO: MAKE LOADING CIRCLE AND BLACK BACKGROUND DISAPPEAR
                
                // AT THIS POINT, inkHub COULD NOT CREATE ACCOUNT ? MAYBE BECAUSE EMAIL ALREADY EXISTS
                print("CALEB: Unable to authenticate with Firebase using email")
                
                // TODO: IN THE SIGN UP VIEW, MAKE A LABEL APPEAR THAT SAYS "PLEASE TRY ANOTHER EMAIL"
                
                
            } else {
                
                // TODO: MAKE LOADING CIRCLE AND BLACK BACKGROUND DISAPPEAR
                
                print("CALEB: Successfully authenticated with Firebase using email")
                if let user = user {
                    let userData = ["provider": user.user.providerID]
                    self.completeSignIn(id: user.user.uid, userData: userData)
                }
                
            }
        })
         */
    }
    
    
    
    
    
    @IBAction func alreadyHaveAnAccountTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
