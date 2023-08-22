//
//  PostManager.swift
//  Nestup
//
//  Created by Aaron Arellano on 2023-08-22.
//

import Foundation
import SwiftUI
import Firebase

class PostManager: ObservableObject {
    @State private var storageManager: StorageManager = StorageManager()
    private let keyLength = 10
    let db = Firestore.firestore()
    
    func fetchUserData(_ uid: String, completion: @escaping (String?, Error?) -> Void) {

        let docRef = db.collection("userData").document(uid)

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
                    completion(data["username"] as? String ?? "", nil)
                }
            }
        }
    }
    
    func setUsername(_ email: String, _ username: String, completion: @escaping (Bool, Error?) -> Void) {

        let docRef = db.collection("userData").document(email)

        docRef.setData(["username": username]) { error in
            if let error = error {
                print("Error writing document: \(error)")
                completion(false, error)
            } else {
                print("Successfully written!")
                completion(true, nil)
            }
        }
    }
    
    
    func generateKey(length: Int, completion: @escaping (String, Error?) -> Void) {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let collectionRef = db.collection("posts")
        
        var pID = String((0..<length).map{ _ in letters.randomElement()! })
        var pIDvalid = false
        
        while !pIDvalid {
            collectionRef.whereField("postID", isEqualTo: pID).getDocuments { snapshot, error in
                if let error = error {
                    completion("", error)
                    return
                }

                if let documents = snapshot?.documents, !documents.isEmpty {
                    pID = String((0..<length).map{ _ in letters.randomElement()! })
                } else {
                    pIDvalid = true
                }
            }
        }
        
        completion(pID, nil)
    }
}
