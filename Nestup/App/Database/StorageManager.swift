//
//  StorageManager.swift
//  Nestup
//
//  Created by Aaron Arellano on 2023-08-22.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseStorage

class StorageManager: ObservableObject {
    let storage = Storage.storage()
    
    func uploadImageFBStorage(image: UIImage) {
        let storageRef = storage.reference().child("images/image.jpg")
        let data = image.jpegData(compressionQuality: 0.2)

        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        if let data = data {
            storageRef.putData(data, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print("Error while uploading file: ", error)
                }
                if let metadata = metadata {
                    print("Upload successful: ", metadata)
                }
            }
        }
    }
}
