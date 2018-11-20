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
        
        // this prevents tableview from being jumpy when like button is pressed
        tableView.estimatedRowHeight = 450
        
        // lower opacity of buttons
        self.plusButton.alpha = 0.8
        self.plusButton.adjustsImageWhenHighlighted = true
        self.signOutButton.alpha = 0.8
        self.signOutButton.adjustsImageWhenHighlighted = true
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        DataService.ds.REF_POSTS.queryOrdered(byChild: "postedDate").observe(.value) { (snapshot) in
            
            // clears out posts array each time its loaded
            // so you dont have duplicated posts
            self.posts = []
            
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.insert(post, at: 0)
                    }
                }
            }
            self.tableView.reloadData()
            
        }
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        // scroll to the top ?
        self.tableView.setContentOffset(.zero, animated: false)
        

        
    }
    
    // reload data each time view appears
    override func viewWillAppear(_ animated: Bool) {
        DataService.ds.REF_POSTS.queryOrdered(byChild: "postedDate").observe(.value) { (snapshot) in
            
            // clears out posts array each time its loaded
            // so you dont have duplicated posts
            self.posts = []
            
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.insert(post, at: 0)
                    }
                }
            }
        }
        self.tableView.reloadData()
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
    
    @IBAction func signOutButtonTapped(_ sender: UIButton) {
        // first remove data from keychain then dismiss VC
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("CALEB: ID removed from keychain \(keychainResult)")
        try! Auth.auth().signOut()
        self.dismiss(animated: false, completion: nil)
    }
    
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        
    }
    

    
    

}
