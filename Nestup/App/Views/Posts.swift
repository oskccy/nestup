//
//  Posts.swift
//  Nestup
//
//  Created by Aaron Arellano on 2023-08-10.
//

import SwiftUI

struct PostView: View {
    var post: Post
    
    var body: some View {
        VStack {
            GroupBox(label: Text(post.title)) {
                Text(post.text)
            }
            .padding(10.0)
            
        }
    }
}

struct Posts: View {
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns:
                    Array(repeating: GridItem(.flexible(), spacing: 16), count: 2),
                          spacing: 16) {
                    ForEach(posts, id: \.self) { post in
                        NavigationLink(destination: PostView(post:post)) {
                            Text(post.title)
                                .padding()
                                .frame(width: 150, height: 180)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 2)
                                )
                            }
                        }
                    }
                    .navigationTitle("Posts")
            }
        }
    }
}

struct Posts_Previews: PreviewProvider {
    static var previews: some View {
        Posts()
    }
}
