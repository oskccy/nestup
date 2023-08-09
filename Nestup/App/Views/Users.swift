//
//  Users.swift
//  Nestup
//
//  Created by Aaron Arellano on 2023-08-08.
//

import SwiftUI

struct UserView: View {
    var user: User
    
    var body: some View {
        HStack {
            Text(user.firstname)
                .font(.title)
                .foregroundColor(Color.red)
            Text(user.lastname)
                .font(.title)
            Text(user.email)
                .font(.caption)
        }
    }
}

struct Users: View {
    var body: some View {
        List(users) { user in
            UserView(user: user)
        }
    }
}

struct Users_Previews: PreviewProvider {
    static var previews: some View {
        Users()
    }
}
