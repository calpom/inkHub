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
    @IBOutlet weak var warningLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // NOTE: viewDidLoad() cannot perform segues. instead use viewDidAppear
        warningLabel.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // if user signed in already, utilize dat segue
        warningLabel.isHidden = true
        emailField.text = ""
        pwdField.text = ""
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
                    let userData = ["provider": credential.provider]
                    self.completeSignIn(id: user.user.uid, userData: userData)
                }
                
            }
        })
    }
    

    
    
    // WHEN SIGN IN BUTTON IS CLICKED
    @IBAction func signInTapped(_ sender: Any) {
        
        // TODO: Make loading circle thing appear and below it a translucent black background
        
        // TODO: make warning label disappear
        
        if let email = self.emailField.text, let pwd = self.pwdField.text {

            if pwd.count < 6 {
                // TODO: make warning label appear and make it say
                // "password must be at least 6 characters long"
                print("CALEB: Password is too short")
                warningLabel.text = "Password must be at least 6 characters long"
                warningLabel.isHidden = false
                return
            }
            
            // inkHub is now attempting to sign in with the given email and password
            Auth.auth().signIn(withEmail: email, password: pwd, completion:{ (user, error) in
                if error == nil {
                    print("CALEB: Email User account found and authenticated")
                    if let user = user {
                        let userData = ["provider": user.user.providerID]
                        self.completeSignIn(id: user.user.uid, userData: userData)
                    }
                } else {
                    // AT THIS POINT, USER WAS NOT ABLE TO SIGN IN.
                    self.warningLabel.text = "User not found"
                    self.warningLabel.isHidden = false
                    return
                    
                    
                }
            })
        }
    }
    
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
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

