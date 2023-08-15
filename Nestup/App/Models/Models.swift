//
//  Models.swift
//  Nestup
//
//  Created by Aaron Arellano on 2023-08-10.
//

import Foundation
import SwiftUI

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
    var id: Int
    var postType: String
    var profile: String
    var profilePic: String
    var title: String
    var image: String
    var text: String
    var caption: String
    var likes: Int
    var date: String
}
