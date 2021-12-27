//
//  Tweet.swift
//  TwitterClone2
//
//  Created by Taehoon Kim on 2021/12/27.
//

import Foundation

struct Tweet {
    let caption: String
    let likes: Int
    var timestamp: Date!
    let retweetCount: Int
    let user: User
    
    init(user: User, dictonary: [String: Any]) {
        self.user = user
        self.caption = dictonary["caption"] as? String ?? ""
        self.likes = dictonary["likes"] as? Int ?? 0
        self.retweetCount = dictonary["retweetCount"] as? Int ?? 0
        if let timestamp = dictonary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
    }
}
