//
//  FirestoreManager.swift
//  Nestup
//
//  Created by Aaron Arellano on 2023-08-21.
//

import Foundation
import SwiftUI
import Firebase

class UserManager: ObservableObject {
    let db = Firestore.firestore()
    
    func fetchUserData(_ uid: String, completion: @escaping (String?, String?, Error?) -> Void) {

        let docRef = db.collection("userData").document(uid)

        docRef.getDocument { (document, error) in
            guard error == nil else {
                print("error", error ?? "")
                completion(nil, nil, error)
                return
            }

            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    print("data", data)
                    
                    completion(data["username"] as? String ?? "", data["profilePic"] as? String ?? "", nil)
                }
            }
        }
    }
    
    func initUser(_ email: String, _ username: String, completion: @escaping (Bool, Error?) -> Void) {

        let docRef = db.collection("userData").document(email)

        docRef.setData(["username": username, "likes": [String]()]) { error in
            if let error = error {
                print("Error writing document: \(error)")
                completion(false, error)
            } else {
                print("Successfully written!")
                completion(true, nil)
            }
        }
    }
    
    func isUsernameUnique(_ username: String, completion: @escaping (Bool, Error?) -> Void) {
        let collectionRef = db.collection("userData")

        collectionRef.whereField("username", isEqualTo: username).getDocuments { snapshot, error in
            if let error = error {
                completion(false, error)
                return
            }

            if let documents = snapshot?.documents, !documents.isEmpty {
                completion(false, nil)
            } else {
                completion(true, nil)
            }
        }
    }
}
