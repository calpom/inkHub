//
//  Post.swift
//  inkHub
//
//  Created by Kaleb  on 11/18/18.
//  Copyright © 2018 KMTech. All rights reserved.
//

import Foundation

class Post {
    
    private var _title: String!
    private var _content: String!
    private var _likes: Int!
    private var _postKey: String!
    
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
    
    init(title: String, content: String, likes: Int) {
        self._title = title
        self._content = content
        self._likes = likes
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
    }
}
