//
//  LikeManager.swift
//  Nestup
//
//  Created by Aaron Arellano on 2023-09-11.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseStorage

class LikeManager: ObservableObject {
    let db = Firestore.firestore()
    
    func like(_ pid: String, completion: @escaping (Bool, Error?) -> Void) {
        let docRef = db.collection("posts").document(pid)
        let user = Auth.auth().currentUser
        let userRef = db.collection("userData").document(user?.email ?? "")
        
        docRef.updateData(["likes": FieldValue.increment(Int64(1))]) { error in
            if let error = error {
                print("Error liking document: \(error)")
                completion(false, error)
            } else {
                userRef.updateData(["likes": FieldValue.arrayUnion([pid])]) { error in
                    if let error = error {
                        print("Error updating user likes array: \(error)")
                    } else {
                        print("Success!")
                        completion(true, nil)
                    }
                }
            }
        }
    }
    
    func unlike(_ pid: String, completion: @escaping (Bool, Error?) -> Void) {
        let docRef = db.collection("posts").document(pid)
        let user = Auth.auth().currentUser
        let userRef = db.collection("userData").document(user?.email ?? "")
        
        docRef.updateData(["likes": FieldValue.increment(Int64(-1))]) { error in
            if let error = error {
                print("Error unliking document: \(error)")
                completion(false, error)
            } else {
                userRef.updateData(["likes": FieldValue.arrayRemove([pid])]) { error in
                    if let error = error {
                        print("Error updating user likes array: \(error)")
                    } else {
                        print("Success!")
                        completion(true, nil)
                    }
                }
            }
        }
    }
    
    func isLiked(_ pid: String, completion: @escaping (Bool?, Error?) -> Void) {
        let user = Auth.auth().currentUser
        let userRef = db.collection("userData").document(user?.email ?? "")
        
        print(user?.email ?? "No current user.")
        
        userRef.getDocument { (document, error) in
            guard error == nil else {
                print("error", error ?? "")
                completion(nil, error)
                return
            }

            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    let likedPosts = data["likes"]! as! NSMutableArray
                    
                    if likedPosts.count != 0 {
                        if (likedPosts.contains(pid)) {
                            completion(true, nil)
                        } else {
                            completion(false, nil)
                        }
                    } else {
                        completion(false, nil)
                    }
                }
            } else {
                completion(false, nil)
            }
        }
    }
}
