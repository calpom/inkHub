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
    @IBOutlet weak var signOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // lower opacity of buttons
        plusButton.alpha = 0.8
        plusButton.adjustsImageWhenHighlighted = true
        signOutButton.alpha = 0.8
        signOutButton.adjustsImageWhenHighlighted = true
        
    }
    
    @IBAction func signOutButtonTapped(_ sender: UIButton) {
        // first remove data from keychain then dismiss VC
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("CALEB: ID removed from keychain \(keychainResult)")
        try! Auth.auth().signOut()
        dismiss(animated: false, completion: nil)
    }
    
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        
    }
    

    
    

}
