//
//  FeedCell.swift
//  Nestup
//
//  Created by Oscar Spencer on 2023-08-09.
//

import SwiftUI

struct PostCell: View {
    @State private var storageManager: StorageManager = StorageManager()
    @State private var likeManager : LikeManager = LikeManager()
    @State var image: UIImage = UIImage()
    @State var liked: Bool? = nil
    
    var post: Post
    
    func loadImage() {
        if post.postType == "image" || post.postType == "hybrid" {
            storageManager.fetchImage(post.id) { data, error in
                if error != nil {
                    print(error?.localizedDescription ?? "")
                } else {
                    print("image type \(type(of: image))")
                    print("data! type \(type(of: data!))")
                    
                    image = UIImage(data: data!) ?? UIImage()
                    print("update image wtih: \(image)")
                }
            }
        }
    }
    
    func checkLiked() {
        likeManager.isLiked(post.id) { liked, error in
            if error != nil {
                print(error?.localizedDescription ?? "Error chceking if liked.")
            } else {
                if liked ?? false {
                    self.liked = true
                } else {
                    self.liked = false
                }
            }
        }
    }
    
    func likeAction() {
        if liked ?? false {
            likeManager.unlike(post.id) { success, error in
                if !success {
                    if error != nil {
                        print("Error liking.")
                    } else {
                        print("Failed")
                    }
                } else {
                    liked = false
                }
            }
        } else {
            likeManager.like(post.id) { success, error in
                if !success {
                    if error != nil {
                        print("Error liking.")
                    } else {
                        print("Failed")
                    }
                } else {
                    liked = true
                }
            }
        }
    }
    

    
    var body: some View {
        VStack {
            HStack {
                Text(post.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                    
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
                    Text(postText)
                }
                else if (post.postType == "hybrid") {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 400)
                        .clipShape(Rectangle())
                    Text(postText)
                }
            }
            .padding(.all)
            .cornerRadius(20.0)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(hue: 1.0, saturation: 0.0, brightness: 0.736), lineWidth: 1)
            )
            .onAppear {
                loadImage()
                checkLiked()
            }
            
            // action buttons
            HStack (spacing: 16) {
                Button {
                    likeAction()
                } label: {
                    Image(systemName: liked ?? false ? "heart.fill" : "heart")
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
            
            //caption label
            
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
            
            Divider()
                .frame(height: 1)
                .padding(.horizontal, 30)
                .background(.black)
        }
    }
    
    var postText: String {
        if post.text.count > 50 {
            let endIndex = post.text.index(post.text.startIndex, offsetBy: 50)
            return String(post.text[..<endIndex] + "...")
        } else {
            return post.text
        }
    }
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell(post:posts[0])
    }
}
