//
//  User.swift
//  Nestup
//
//  Created by Aaron Arellano on 2023-08-08.
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
