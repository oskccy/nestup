//
//  ProfileView.swift
//  Nestup
//
//  Created by Oscar Spencer on 2023-08-09.
//

import SwiftUI

struct ProfileView: View {
    var user: User
    
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // main header
                VStack (spacing: 10) {
                    // pic and stats
                    HStack {
                        Text(user.username)
                            .font(.title)
                            .padding(.trailing)
                        
                        
                        Image(user.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                    }
                    .padding()
                    // name + extra info
                    VStack(spacing: 4) {
                        Text(user.bio)
                            .font(.callout)
                            .frame(width: 50, height: 50)
                        HStack {
                            UserStatView(value: user.followers, title: "Followers")
                            UserStatView(value: user.following, title: "Following")
                        }
                    }
                    .padding(.horizontal)

                    //divier
                    Button {
                        
                    } label: {
                        Text("Edit Profile")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .frame(width: 320, height: 32)
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    }
                    .padding()
                    Divider()
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.gray, lineWidth: 1)
                )
                .padding()
                
                // posts grid view
                
                VStack {
                    Text("Posts")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .padding()
                    LazyVGrid(columns: gridItems, spacing: 1) {
                        ForEach(0 ... 15, id: \.self) {
                            index in Image("popping-bottle")
                                .resizable()
                                .scaledToFill()
                        }

                    }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding()
                
                
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: users[1])
    }
}
