//
//  GoogleAuth.swift
//  Nestup
//
//  Created by Aaron Arellano on 2023-08-29.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import Firebase

struct GoogleAuth {
    func signinWithGoogle(completion: @escaping (Bool, Error?) -> Void) {
        
        guard let presenting = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}
        
        print("getting clientID")
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        print(clientID)

        print("getting config")
        let config = GIDConfiguration(clientID: clientID)
        print(config)
        
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        print("starting sign in flow")
        GIDSignIn.sharedInstance.signIn(withPresenting: presenting) { result, error in

            if let error = error {
                print("error in sign in flow: ",error.localizedDescription)
                completion(false, error)
                return
            }
            
            print("getting user and idtoken")
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                print("error getting user and idtoken")
                completion(false, nil)
                return
            }

            print("credential get")
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)
            
            print("signing in")
            Auth.auth().signIn(with: credential) { result, error in
                guard error == nil else {
                    completion(false, error)
                    return
                }
                completion(true, nil)
                print("SIGNED IN")
            }
        }
    }
}
