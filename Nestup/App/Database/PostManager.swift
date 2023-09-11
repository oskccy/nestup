//
//  PostManager.swift
//  Nestup
//
//  Created by Aaron Arellano on 2023-08-22.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class PostManager: ObservableObject {
    @State private var storageManager: StorageManager = StorageManager()
    private let keyLength = 10
    let db = Firestore.firestore()
    
    func fetchPostData(_ pid: String, completion: @escaping ([Any]?, Error?) -> Void) {

        let docRef = db.collection("posts").document(pid)

        docRef.getDocument { (document, error) in
            guard error == nil else {
                print("error", error ?? "")
                completion(nil, error)
                return
            }

            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    print("data", data)
                    completion(data as? Array ?? nil, nil)
                }
            }
        }
    }
    
    func upload(_ post: Post, _ image: UIImage?, completion: @escaping (Bool, Error?) -> Void) {
        
        let postId = self.generateKey(length: keyLength)
        
        do {
            let docRef = self.db.collection("posts").document(postId)
            var postData = try Firestore.Encoder().encode(post)
            postData["id"] = postId

            docRef.setData(postData) { error in
                if let error = error {
                    print("Error writing document: \(error)")
                    completion(false, error)
                } else {
                    print("Successfully written!")

                    if post.postType == "image" || post.postType == "hybrid" {
                        self.storageManager.uploadImageFBStorage(image: image ?? UIImage(), postId: postId) { suc, error in
                            if !suc {
                                completion(false, error)
                            } else {
                                completion(true, nil)
                            }
                        }
                    } else {
                        completion(true, nil)
                    }
                }
            }
        } catch {
            print("Set data error: ", error)
            completion(false, error)
        }
    }
    
    
    func generateKey(length: Int) -> String{
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let collectionRef = db.collection("posts")
        
        var pID = String((0..<length).map{ _ in letters.randomElement()! })
        
        collectionRef.whereField("postID", isEqualTo: pID).getDocuments {  snapshot, error in
            if error != nil {
                pID = self.generateKey(length: self.keyLength)
            }
        }

        return pID
    }
    
    func getDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d,yyyy h:mma"
        return dateFormatter.string(from: date)
    }
    
    func getTags(_ title: String, _ text: String, _ caption: String) -> Array<String> {
        var postText = title + " " + text + " " + caption
        postText = postText.lowercased()
        for sChar in specialChars {
            postText = postText.replacingOccurrences(of: sChar, with: "")
        }
        
        var postTags = postText.components(separatedBy: " ")
        for cWord in commonWords {
            postTags = postTags.filter { $0 != cWord }
        }
        postTags = Array(Set(postTags))
        
        return postTags
    }
}
