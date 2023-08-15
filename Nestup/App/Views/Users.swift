////
////  Users.swift
////  Nestup
////
////  Created by Aaron Arellano on 2023-08-08.
////
//
//import SwiftUI
//
//struct UserView: View {
//    var user: User
//
//    var body: some View {
//        HStack {
//            Text(user.firstname)
//                .foregroundColor(user.vip ? .red : .black)
//                .font(.body)
//            Text(user.lastname)
//                .foregroundColor(user.vip ? .red : .black)
//                .font(.body)
//            Text(user.email)
//                .font(.caption)
//
//        }
//    }
//}
//
//struct Users: View {
//    var body: some View {
//        NavigationView {
//            ZStack {
//                List(users) { user in
//                    NavigationLink {
//                        UserView(user: user)
//                    } label: {
//                        Text(user.firstname)
//                    }
//                }
//                .navigationTitle("Users")
//                .listStyle(InsetListStyle())
//            }
//        }
//
//
//    }
//}
//
//struct Users_Previews: PreviewProvider {
//    static var previews: some View {
//        Users()
//    }
//}
