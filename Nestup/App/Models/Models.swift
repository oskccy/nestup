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
    var date: String
}
