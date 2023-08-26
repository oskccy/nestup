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
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        let rect = CGRect(origin: .zero, size: newSize)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func uploadImageFBStorage(image: UIImage, postId: String, completion: @escaping (Bool, Error?) -> Void) {
        
        let storageRef = storage.reference().child("images/\(postId).jpg")
        let data = resizeImage(image: image, targetSize: CGSize(width: 300, height: 300))?.jpegData(compressionQuality: 0.2)

        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        if let data = data {
            storageRef.putData(data, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print("Error while uploading file: ", error)
                    completion(false, error)
                }
                if let metadata = metadata {
                    print("Upload successful: ", metadata)
                    completion(true, nil)
                }
            }
        }
    }
}
