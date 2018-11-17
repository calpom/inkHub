//
//  FeedVC.swift
//  inkHub
//
//  Created by Kaleb  on 11/16/18.
//  Copyright © 2018 KMTech. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController {

    @IBOutlet weak var plusButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // lower opacity of plus button
        plusButton.alpha = 0.8
        plusButton.adjustsImageWhenHighlighted = true
        
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        
    }
    
    
    // TODO: ASSIGN THIS TO THE SIGN OUT BUTTON WHEN U MAKE IT
    /*
    @IBAction func signOutTapped(_ sender: Any) {
        
        // first remove data from keychain then dismiss VC
        let keychainResult = KeychainWrapper.standard.remove(key: KEY_UID)
        print("CALEB: ID removed from keychain \(keychainResult)")
        try! Auth.auth().signOut()
        dismiss(animated: false, completion: nil)
    }
     */
    
    

}
