//
//  User.swift
//  TwitterClone2
//
//  Created by Taehoon Kim on 2021/12/27.
//

import Foundation
import Firebase

struct User {
    let fullname: String
    let email: String
    let username: String
    
    init(dictionary: [String: AnyObject]) {
        self.fullname = dictionary["fullname"] as? String ?? "seougu goo"
        self.email = dictionary["email"] as? String ?? "mozell@naver.com"
        self.username = dictionary["username"] as? String ?? "승구"
    }
}
