//
//  Models.swift
//  Nestup
//
//  Created by Aaron Arellano on 2023-08-10.
//

import Foundation
import SwiftUI

class UserSession: ObservableObject {
    @Published var authenticated: Bool = false
    @Published var failedAuth: Bool = false
    @Published var failedCreate: Bool = false
}

class CreateUser: ObservableObject {
    @Published var email: String = ""
    @Published var username: String = ""
    @Published var password: String = ""
}

struct User: Hashable, Codable, Identifiable {
    var id: Int
    var username: String
    var image: String
    var followers: Int
    var following: Int
    var bio: String
    var firstname: String
    var lastname: String
    var email: String
}

struct Post: Hashable, Codable, Identifiable {
    var id: String
    var postType: String
    var profile: String
    var profileUId: String
    var profilePic: String
    var title: String
    var text: String
    var caption: String
    var likes: Int
    var tags: Array<String>
    var date: String
    
    init(id: String, postType: String, profile: String, profileUId: String, profilePic: String, title: String, text: String, caption: String, likes: Int, tags: [String], date: String) {
        self.id = id
        self.postType = postType
        self.profile = profile
        self.profileUId = profileUId
        self.profilePic = profilePic
        self.title = title
        self.text = text
        self.caption = caption
        self.likes = likes
        self.tags = tags
        self.date = date
    }

    init(dictionary: Dictionary<String, Any>) {
        self.id = dictionary["id"] as? String ?? ""
        self.postType = dictionary["postType"] as? String ?? ""
        self.profile = dictionary["profile"] as? String ?? ""
        self.profileUId = dictionary["profileUId"] as? String ?? ""
        self.profilePic = dictionary["profilePic"] as? String ?? ""
        self.title = dictionary["title"] as? String ?? ""
        self.text = dictionary["text"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.tags = dictionary["tags"] as? [String] ?? []
        self.date = dictionary["date"] as? String ?? ""
    }
}
