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
    private var _postedDate: Int!
    
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
    
    var postedDate: Int {
        return _postedDate
    }
    
    init(title: String, content: String, likes: Int, profilePicUrl: String, postedDate: Int) {
        self._title = title
        self._content = content
        self._likes = likes
        self._profilePicUrl = profilePicUrl
        self._postedDate = postedDate
        self._postRef = DataService.ds.REF_POSTS.child(self._postKey)
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
        if let postedDate = postData["postedDate"] as? Int {
            self._postedDate = postedDate

        }
        
        self._postRef = DataService.ds.REF_POSTS.child(self._postKey)

    }
    
    
    // maybe we need a getter? Cause this shit not working
    
    func adjustLikes(addLike: Bool) {
        if addLike {
            self._likes = self._likes + 1
        } else {
            self._likes = self._likes - 1
        }
        
        _postRef.child("likes").setValue(self._likes)
    }
}
