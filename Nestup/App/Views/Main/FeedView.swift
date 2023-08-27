//
//  FeedView.swift
//  Nestup
//
//  Created by Oscar Spencer on 2023-08-09.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack (spacing: 32) {
                    ForEach(posts, id: \.self) { post in
                        NavigationLink(destination:
                                ScrollView {
                                    PostView(post:post)
                                }
                            ){
                                PostCell(post:post)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                }
                .padding(.vertical)
                    .navigationTitle("Feed")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Image("nestup-logo")
                                .resizable()
                                .frame(width: 80, height: 40)
                        }
                    }
                }
            }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
