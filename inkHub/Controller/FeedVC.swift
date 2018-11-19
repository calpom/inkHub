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

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TESTING:
        tableView.estimatedRowHeight = 450
 
        
        // * * * * * * * *
        
        
        // lower opacity of buttons
        plusButton.alpha = 0.8
        plusButton.adjustsImageWhenHighlighted = true
        signOutButton.alpha = 0.8
        signOutButton.adjustsImageWhenHighlighted = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.ds.REF_POSTS.observe(.value) { (snapshot) in
            
            // clears out posts array each time its loaded
            // so you dont have duplicated posts
            self.posts = []
            
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
            
        }
        
        
        
    }
    
    // reload data each time view appears
    override func viewWillAppear(_ animated: Bool) {
        print("CALEB: View will appear")
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
            if let img = FeedVC.imageCache.object(forKey: post.profilePicUrl as NSString) {
                cell.configureCell(post: post, img: img)
            } else {
                cell.configureCell(post: post)
            }
            return cell
        } else {
            return PostCell()
        }
    }
    
    // * * * * * TESTING * * * * *
    /*
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
     */
    /*
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
     */
    
    // * * * * * * * * * * * * * *
    
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
