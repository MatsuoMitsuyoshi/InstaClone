//
//  Comment.swift
//  InstaClone
//
//  Created by mitsuyoshi matsuo on 2019/04/30.
//  Copyright © 2019 mitsuyoshi matsuo. All rights reserved.
//

import Foundation
import Firebase

class Comment {
    
    var uid: String!
    var commentText: String!
    var creationDate: Date!
    var user: User?
    
    init(user: User, dictionary: Dictionary<String, AnyObject>) {
        
        self.user = user
        
        if let uid = dictionary["uid"] as? String {
//            self.uid = uid
            Database.fetchUser(with: uid) { (user) in
                self.user = user
            }
        }
        
        if let commentText = dictionary["commentText"] as? String {
            self.commentText = commentText
        }
        
        if let creationDate = dictionary["creationDate"] as? Double {
            self.creationDate = Date(timeIntervalSince1970: creationDate)
        }
    }
}
