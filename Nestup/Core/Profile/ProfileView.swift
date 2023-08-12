//
//  ProfileView.swift
//  Nestup
//
//  Created by Oscar Spencer on 2023-08-09.
//

import SwiftUI

struct ProfileView: View {
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1)
    ]
    var body: some View {
        NavigationStack {
            ScrollView {
                // main header
                VStack (spacing: 10){
                    // pic and stats
                    HStack {
                        Image("default")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                        
                        Spacer()
                        
                        HStack(spacing: 8) {
                           UserStatView(value: 3, title: "Posts")
                            
                           UserStatView(value: 23, title: "Followers")
                            
                           UserStatView(value: 23, title: "Following")
                        }
                    }
                    .padding(.horizontal)
                    // name + extra info
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Aaron Arellano")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                        Text("I'm a loser lmao")
                            .font(.footnote)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                    //divier
                    Button {
                        
                    } label: {
                        Text("Edit Profile")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .frame(width: 360, height: 32)
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    }
                    Divider()
                }
                
                // posts grid view
                
                LazyVGrid(columns: gridItems, spacing: 1) {
                    ForEach(0 ... 15, id: \.self) {
                        index in Image("oscar")
                            .resizable()
                            .scaledToFill()
                    }

                }
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
        ProfileView()
    }
}
