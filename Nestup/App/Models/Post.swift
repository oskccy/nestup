//
//  Post.swift
//  Nestup
//
//  Created by Aaron Arellano on 2023-08-09.
//

import Foundation
import SwiftUI


struct Post: Hashable, Codable, Identifiable {
    var id: Int
    var firstname: String
    var lastname: String
    var email: String
    var vip: Bool
}
