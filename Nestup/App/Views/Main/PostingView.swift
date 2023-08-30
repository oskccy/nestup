//
//  PostingView.swift
//  Nestup
//
//  Created by Aaron Arellano on 2023-08-22.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct PostingView: View {
    @State private var postManager: PostManager = PostManager()
    @State private var userManager: UserManager = UserManager()
    @State private var chooseImage = false
    @State private var invalidPost = false
    @State private var errorRe = ""

    @State var title = ""
    @State var text = ""
    @State var caption = ""
    @State var selectImage = UIImage()
    
    func post() {
        let user = Auth.auth().currentUser!
        
        userManager.fetchUserData(user.email!) { username, profilePic, error in
            if error != nil {
                invalidPost = true
                errorRe = error?.localizedDescription ?? "error"
            } else if title == "" {
                invalidPost = true
                errorRe = "Please provide this post a title."
                
            } else if text == "" && selectImage.size.width == 0 {
                invalidPost = true
                errorRe = "Please provide this post with a text and/or an image."
            } else {
                invalidPost = false
                if text != "" || selectImage.size.width != 0 {
                    var postType = "hybrid"
                    if text != "" && selectImage.size.width == 0{
                        postType = "text"
                    } else if selectImage.size.width != 0 && text == ""{
                        postType = "image"
                    }
                    
                    let post = Post(
                        id: "",
                        postType: postType,
                        profile: username ?? "",
                        profileUId: user.uid ,
                        profilePic: profilePic ?? "",
                        title: title,
                        text: text,
                        caption: caption,
                        likes: 0,
                        date: postManager.getDate()
                    )
                    
                    let image = selectImage.size.width != 0 ? selectImage : nil
                    
                    postManager.upload(post, image) { suc, error in
                        if !suc {
                            print(error ?? "Error uploading")
                        }
                    }
                    
                    self.emptyFields()
                }
            }
        }
    }
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    TextField("Title", text: $title)
                        .font(/*@START_MENU_TOKEN@*/.title3/*@END_MENU_TOKEN@*/)
                        .frame(width: 275, height: 30)
                        .modifier(PostTextField())
                    
                    Group {
                        if selectImage.size.width != 0 {
                            Image(uiImage: selectImage)
                                .resizable()
                        } else {
                            Text("Image (optional)")
                                .font(.body)
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(width: 275, height: 275)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                            .foregroundColor(.gray)
                    )
                    
                    HStack {
                        Button {
                            chooseImage.toggle()
                        } label: {
                            Label("Choose Image", systemImage: "photo")
                        }
                        
                        Button {
                            selectImage = UIImage()
                        } label: {
                            Label("Remove Image", systemImage: "trash.fill")
                                .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
                        }
                    }
                    
                    TextField("Text (optional)", text: $text, axis: .vertical)
                        .font(.body)
                        .frame(width: 275, height: 80)
                        .modifier(PostTextField())
                        .lineLimit(/*@START_MENU_TOKEN@*/5/*@END_MENU_TOKEN@*/)
                    
                    TextField("Caption", text: $caption)
                        .font(/*@START_MENU_TOKEN@*/.callout/*@END_MENU_TOKEN@*/)
                        .frame(width: 275, height: 25)
                        .modifier(PostTextField())
                    
                    Button {
                        post()
                    } label: {
                        Text("Post")
                            .padding()
                            .frame(width: 150, height: 40)
                            .foregroundColor(.white)
                            .modifier(PostTextField())
                            .background(.blue)
                            .cornerRadius(100)
                    }
                }
                .sheet(isPresented: $chooseImage) {
                    ImagePicker(sourceType: .photoLibrary, selectedImage: $selectImage)
                }
                .alert(isPresented: $invalidPost) {
                    Alert(
                        title: Text("Error while uploading."),
                        message: Text(errorRe),
                        primaryButton: .default(Text("OK")),
                        secondaryButton: .cancel(Text("Cancel"))
                    )
                }
            }
            .navigationTitle("Post")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func emptyFields() {
        title = ""
        text = ""
        caption = ""
        selectImage = UIImage()
    }
}

struct PostingView_Previews: PreviewProvider {
    static var previews: some View {
        PostingView()
    }
}
