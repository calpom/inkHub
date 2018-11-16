//
//  ViewController.swift
//  inkHub
//
//  Created by Kaleb  on 11/15/18.
//  Copyright © 2018 KMTech. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var pwdField: FancyField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    // authenticate with facebook
    @IBAction func facebookBtnTapped(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("CALEB: Unable to authenticate with Facebook ! \(String(describing: error))")
            } else if result?.isCancelled == true {
                print("CALEB: User cancelled Facebook authentication")
            } else {
                print("CALEB: Successfully authenticated with Facebook")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
        
    }
    
    // authenticate with firebase
    func firebaseAuth(_ credential: AuthCredential) {
        Auth.auth().signInAndRetrieveData(with: credential, completion: { (user, error) in
            if error != nil {
                print("CALEB: Unable to authenticate with Firebase ! - \(String(describing: error))")
            } else {
                print("CALEB: Successfully authenticated with Firebase !")
            }
        })
    }
    
    
    // WHEN SIGN IN BUTTON IS CLICKED
    @IBAction func signInTapped(_ sender: Any) {
        
        // TODO: make warning label disappear
        
        if let email = emailField.text, let pwd = pwdField.text {

            if pwd.count < 6 {
                // TODO: make label appear that says password must be at least 6 characters long
                print("CALEB: Password is too short")
                return
            }
            
            // inkHub is now attempting to sign in with the given email and password
            Auth.auth().signIn(withEmail: email, password: pwd, completion:{ (user, error) in
                if error == nil {
                    print("CALEB: Email User account found and authenticated")
                } else {
                    // AT THIS POINT, USER WAS NOT ABLE TO SIGN IN. CURRENTLY IT MAKES EMAIL AUTOMATICALLY BUT INSTEAD
                    // WE SHOULD PUT IN A SIGN UP BUTTON THAT OPENS A NEW VIEW THAT ALLOWS USER TO CREATE ACCOUNT
                    // TODO: MAKE A LABEL APPEAR THAT SAYS PLEASE TRY AGAIN
                    
                    
                    // TODO: ADD A SIGN UP BUTTON THAT USES BELOW METHOD AND MAKES SURE "CONFIRM PASSWORD" FIELD IS THERE
                    
                    
                    // THIS IS THE METHOD THAT CREATES USER (USE IT FOR ABOVE TODO)
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            
                            // AT THIS POINT, inkHub COULD NOT CREATE ACCOUNT ? MAYBE BECAUSE EMAIL ALREADY EXISTS
                            print("CALEB: Unable to authenticate with Firebase using email")
                            
                            // TODO: IN THE SIGN UP VIEW, MAKE A LABEL APPEAR THAT SAYS "PLEASE TRY ANOTHER EMAIL"
                            
                            
                        } else {
                            print("CALEB: Successfully authenticated with Firebase using email")
                        }
                    })
                }
            })
        }
    }
    
    
    // This method will hide the keyboard when touch is outside the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    


}

