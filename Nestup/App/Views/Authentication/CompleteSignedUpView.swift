//
//  CompleteSignedUpView.swift
//  Nestup
//
//  Created by Oscar Spencer on 2023-08-10.
//

import SwiftUI
import Firebase

struct CompleteSignedUpView: View {
    @EnvironmentObject var userSession: UserSession
    @EnvironmentObject var createUser : CreateUser
   
    @Environment(\.dismiss) var dismiss
    
    @State private var errorRe: String = ""
    @State private var userManager: UserManager = UserManager()
    
    func signup() {
        userManager.isUsernameUnique(createUser.username) { unique, error in
            if error != nil {
                errorRe = error?.localizedDescription ?? ""
                userSession.failedCreate = true
            }
            
            if !unique {
                errorRe = "Username is not unique"
                userSession.failedCreate = true
                
            } else {
                userSession.failedCreate = false
                Auth.auth().createUser(withEmail: createUser.email, password: createUser.password) { authResult, error in
                    
                    if error != nil {
                        errorRe = error?.localizedDescription ?? ""
                        userSession.failedCreate = true
                        print(errorRe)
                    } else {
                        userSession.failedCreate = false
                        userManager.setUsername(createUser.email, createUser.username) { suc, error in
                            
                            if error != nil {
                                errorRe = error?.localizedDescription ?? ""
                                userSession.failedCreate = true
                            } else {
                                userSession.failedCreate = false
                                Auth.auth().signIn(withEmail: createUser.email, password: createUser.password) { (result, error) in

                                    if error != nil {
                                        userSession.failedAuth = true
                                        print(error?.localizedDescription ?? "")
                                    } else {
                                        userSession.authenticated = true
                                        userSession.failedAuth = false
                                    }
                                }
                            }
                        }

                    }
                }
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 12) {
            
            Spacer()
            
            Text("Welcome do Nestup, \(createUser.username)!")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
                .multilineTextAlignment(.center)
            
            Text("Click below to complete registration and start using Nestup")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            Button {
                signup()
            } label: {
                Text("Complete sign up")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 360, height: 44)
                    .foregroundColor(.white)
                    .background(Color(.systemBlue))
                    .cornerRadius(8)
            }
            .padding(.vertical)
            
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .onTapGesture{
                        dismiss()
                    }
            }
        }
        .alert(isPresented: $userSession.failedCreate) {
            Alert(
                title: Text(errorRe),
                message: Text("Please re-enter email, username and password."),
                primaryButton: .default(Text("OK")),
                secondaryButton: .cancel(Text("Cancel"))
            )
        }
    }
}

struct CompleteSignedUpView_Previews: PreviewProvider {
    static var previews: some View {
        CompleteSignedUpView()
            .environmentObject(UserSession())
            .environmentObject(CreateUser())
            .environmentObject(UserManager())
    }
}
