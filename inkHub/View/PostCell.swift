//
//  PostCell.swift
//  inkHub
//
//  Created by Kaleb  on 11/17/18.
//  Copyright © 2018 KMTech. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var likeButton: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    

}
