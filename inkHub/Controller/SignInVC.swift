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
    


}

