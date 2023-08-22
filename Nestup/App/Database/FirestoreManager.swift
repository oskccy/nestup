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
    @Published var username: String = ""
    
    func fetchUserData(_ uid: String, completion: @escaping (String?, Error?) -> Void) {
        let db = Firestore.firestore()

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
        let db = Firestore.firestore()

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
    
    func isUsernameUnique(_ username: String, completion: @escaping (Bool, Error?) -> Void) {
        let db = Firestore.firestore()
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
