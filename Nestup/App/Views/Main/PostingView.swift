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
    @State private var chooseImage = false
    @State private var selectImage = UIImage()
    
    var body: some View {
        VStack {
            Button {
                chooseImage.toggle()
            } label: {
                Text("Upload Image")
            }
            
            Button {
                
            } label: {
                Text("Post image")
            }
        }
        .sheet(isPresented: $chooseImage) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $selectImage)
        }
    }
}

struct PostingView_Previews: PreviewProvider {
    static var previews: some View {
        PostingView()
    }
}
