//
//  Post.swift
//  inkHub
//
//  Created by Kaleb  on 11/18/18.
//  Copyright © 2018 KMTech. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Post {
    
    private var _title: String!
    private var _content: String!
    private var _likes: Int!
    private var _postKey: String!
    private var _profilePicUrl: String!
    private var _postRef: DatabaseReference
    
    var title: String {
        return _title
    }
    
    var content: String {
        return _content
    }
    
    var likes: Int {
        return _likes
    }
    
    var postKey: String {
        return _postKey
    }
    
    var profilePicUrl: String {
        return _profilePicUrl
    }
    
    init(title: String, content: String, likes: Int, profilePicUrl: String) {
        self._title = title
        self._content = content
        self._likes = likes
        self._profilePicUrl = profilePicUrl
        _postRef = DataService.ds.REF_POSTS.child(_postKey)
    }
    
    init(postKey: String, postData: Dictionary<String, AnyObject>) {
        self._postKey = postKey
        
        if let title = postData["title"] as? String{
            self._title = title
        }
        
        if let content = postData["content"] as? String{
            self._content = content
        }
        if let likes = postData["likes"] as? Int{
            self._likes = likes
        }
        if let profilePicUrl = postData["profilePicUrl"] as? String {
            self._profilePicUrl = profilePicUrl
        }
        
        _postRef = DataService.ds.REF_POSTS.child(_postKey)
        
    }
    
    func adjustLikes(addLike: Bool) {
        if addLike {
            _likes = _likes + 1
        } else {
            _likes = _likes - 1
        }
        
        _postRef.child("likes").setValue(_likes)
    }
}
