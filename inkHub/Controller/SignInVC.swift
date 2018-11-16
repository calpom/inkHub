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
import SwiftKeychainWrapper

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var pwdField: FancyField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // NOTE: viewDidLoad() cannot perform segues. instead use viewDidAppear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // if user signed in already, utilize dat segue
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            print("CALEB: ID found in keychain")
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
    }
    
    // authenticate with facebook
    @IBAction func facebookBtnTapped(_ sender: Any) {
        
        // TODO: Make loading circle thing appear and below it a translucent black background
        
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
                if let user = user {
                    self.completeSignIn(id: user.user.uid)
                }
                
            }
        })
    }
    

    
    
    // WHEN SIGN IN BUTTON IS CLICKED
    @IBAction func signInTapped(_ sender: Any) {
        
        // TODO: Make loading circle thing appear and below it a translucent black background
        
        // TODO: make warning label disappear
        
        if let email = emailField.text, let pwd = pwdField.text {

            if pwd.count < 6 {
                // TODO: make warning label appear and make it say
                // "password must be at least 6 characters long"
                print("CALEB: Password is too short")
                return
            }
            
            // inkHub is now attempting to sign in with the given email and password
            Auth.auth().signIn(withEmail: email, password: pwd, completion:{ (user, error) in
                if error == nil {
                    print("CALEB: Email User account found and authenticated")
                    if let user = user {
                        self.completeSignIn(id: user.user.uid)
                    }
                } else {
                    // AT THIS POINT, USER WAS NOT ABLE TO SIGN IN. CURRENTLY IT MAKES EMAIL AUTOMATICALLY BUT INSTEAD
                    // WE SHOULD PUT IN A SIGN UP BUTTON THAT OPENS A NEW VIEW THAT ALLOWS USER TO CREATE ACCOUNT
                    
                    // TODO: MAKE LOADING CIRCLE AND BLACK BACKGROUND DISAPPEAR
                    
                    
                    // TODO: MAKE WARNING LABEL APPEAR AND MAKE IT SAY
                    // PLEASE TRY AGAIN
                    
                    
                    // TODO: ADD A SIGN UP BUTTON THAT USES BELOW METHOD AND MAKES SURE "CONFIRM PASSWORD" FIELD IS THERE
                    
                    
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
                                self.completeSignIn(id: user.user.uid)
                            }
                            
                        }
                    })
                }
            })
        }
    }
    
    func completeSignIn(id: String) {
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        performSegue(withIdentifier: "goToFeed", sender: nil)
        print("CALEB: Data saved to keychain \(keychainResult)")
    }
    
    // TODO: CREATE METHOD THAT MAKES LOADING CIRCLE AND BLACK BACKGROUND DISAPPEAR
    
    
    // This method will hide the keyboard when touch is outside the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    


}

