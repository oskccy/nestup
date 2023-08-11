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
    var firstname: String
    var lastname: String
    var email: String
    var vip: Bool
}

struct Post: Hashable, Codable, Identifiable {
    var id: Int
    var title: String
    var text: String
}
