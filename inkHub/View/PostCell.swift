//
//  PostCell.swift
//  inkHub
//
//  Created by Kaleb  on 11/17/18.
//  Copyright © 2018 KMTech. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {

    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var likeButton: UIImageView!
    
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(post: Post, img: UIImage? = nil) {
        self.post = post
        self.titleLbl.text = post.title
        self.content.text = post.content
        self.likesLbl.text = "\(post.likes)"
        
        if img != nil {
            self.profileImg.image = img
        } else {
            
            let ref = Storage.storage().reference(forURL: post.profilePicUrl)
            ref.getData(maxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("CALEB: Unable to download image from Firebase storage")
                } else {
                    print("Image downloaded from Firebase storage")
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.profileImg.image = img
                            FeedVC.imageCache.setObject(img, forKey: post.profilePicUrl as NSString)
                        }
                    }
                }
            })
            
        }
    }

}
