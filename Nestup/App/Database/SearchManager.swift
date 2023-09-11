//
//  SearchManager.swift
//  Nestup
//
//  Created by Aaron Arellano on 2023-08-31.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class SearchManager: ObservableObject {
    let db = Firestore.firestore()
    
    func getQuery(_ search: String) -> Array<String> {
        return search.components(separatedBy: " ")
    }
    
    func searchPosts(_ query: Array<String>, orderBy order: String = "likes", completion: @escaping (Array<Post>?, Error?) -> Void) {
        
        var posts : [Post] = []
        
        let postsRef = db.collection("posts")
        postsRef.whereField("tags", arrayContainsAny: query).order(by: order).getDocuments() { querySnapshot, error in
            if error != nil {
                print(error?.localizedDescription ?? "error")
                completion(nil, error)
            } else {
                for document in querySnapshot!.documents {
                    print(Post(dictionary: document.data()))
                    posts.append(Post(dictionary: document.data()))
                    print("Posts: \(posts)")
                }
                completion(posts, nil)
            }
        }
    }
}
