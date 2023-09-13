//
//  PostView.swift
//  Nestup
//
//  Created by Aaron Arellano on 2023-08-11.
//

import SwiftUI

struct PostView: View {
    @State private var storageManager: StorageManager = StorageManager()
    @State private var likeManager : LikeManager = LikeManager()
    @State private var image: UIImage = UIImage()
    
    var post: Post
    
    func loadImage() {
        if post.postType == "image" || post.postType == "hybrid" {
            storageManager.fetchImage(post.id) { data, error in
                if error != nil {
                    print(error?.localizedDescription ?? "")
                } else {
                    image = UIImage(data: data!) ?? UIImage()
                    print(image)
                }
            }
        }
    }
    
    var body: some View {
        VStack {
            Text(post.title)
                .font(.title)
                .fontWeight(.semibold)
                .padding()
                
            HStack {
                Text(post.profile)
                    .font(.subheadline)
                    
                Image(post.profilePic)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color(hue: 1.0, saturation: 0.0, brightness: 0.736), lineWidth: 2))
                    .padding(/*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
            }
            
            
            
            VStack {
                if (post.postType == "image") {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 400)
                        .clipShape(Rectangle())
                }
                else if (post.postType == "text") {
                    Text(post.text)
                }
                else if (post.postType == "hybrid") {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 400)
                        .clipShape(Rectangle())
                    Text(post.text)
                }
            }
            .padding(.all)
            .cornerRadius(20.0)
            .onAppear {
                loadImage()
            }
            
            HStack (spacing: 16) {
                Button {
                    print("like post")
                } label: {
                    Image(systemName: "heart")
                        .imageScale(.large)
                }
                .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
                
                Button {
                    print("comment post")
                } label: {
                    Image(systemName: "bubble.right")
                        .imageScale(.large)
                }
                .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
                
                Button {
                    print("share post")
                } label: {
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                }
                .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
            }
            .padding(.top, 4)
            .foregroundColor(.black)
            
            
            Text(post.caption)
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding([.top, .leading, .trailing])
            
            Text(post.date)
                .font(.footnote)
                .fontWeight(.semibold)
                .padding(.top, 1)
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(.gray)
        }
        .padding()
        .overlay(
            Rectangle()
                .stroke(Color(hue: 1.0, saturation: 0.0, brightness: 0.736), lineWidth: 1)
        )
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(post:posts[0])
    }
}
