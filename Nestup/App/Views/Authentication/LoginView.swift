//
//  LoginView.swift
//  Nestup
//
//  Created by Oscar Spencer on 2023-08-09.
//

import SwiftUI
import Firebase
import FirebaseAuth
import GoogleSignIn

struct LoginView: View {
    @EnvironmentObject var userSession: UserSession
    
    @State private var email = ""
    @State private var password = ""
    
    func login() {
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                userSession.failedAuth = true
                print(error?.localizedDescription ?? "")
            } else {
                userSession.authenticated = true
                userSession.failedAuth = false
            }
        }
    }
    
    var body: some View {
        NavigationStack  {
            VStack {
                
                Spacer()
                
                // logo image
                Image("nestup-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 100)
                // text fields
                VStack {
                    TextField("Enter your email", text: $email)
                        .autocapitalization(.none)
                        .modifier(TextFieldModifier())
                    
                    SecureField("Enter your password", text: $password)
                        .modifier(TextFieldModifier())
                }
                
                Button {
                    print("Show forgot password")
                } label: {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.top)
                        .padding(.trailing, 28)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                Button {
                    login()
                } label: {
                    Text("Login")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(width: 360, height: 44)
                        .foregroundColor(.white)
                        .background(Color(.systemBlue))
                        .cornerRadius(8)
                }
                .padding(.vertical)
                
                HStack {
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5)
                    
                    Text("OR")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5)
                        
                }
                .foregroundColor(.gray)
                
                Button {
                    GoogleAuth().signinWithGoogle() { result, error in
                        if error != nil || !result {
                            print("error: ", error?.localizedDescription ?? "error")
                            userSession.failedAuth = true
                        }
                        
                        if result {
                            print("google sign in success")
                            userSession.authenticated = true
                            userSession.failedAuth = false
                        }
                    }
                } label: {
                    HStack {
                        Text("Continue with Google")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.systemBlue))
                    }
                    .padding(.top)
                }
                
                Spacer()
                
                Divider()
                
                NavigationLink {
                    AddEmailView()
                        .environmentObject(CreateUser())
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        
                        Text("Sign Up")
                            .fontWeight(.semibold)
                    }
                    .font(.footnote)
                }
                .padding(.vertical, 16)
            }
            .alert(isPresented: $userSession.failedAuth) {
                Alert(
                    title: Text("Error signing in."),
                    message: Text("Invalid email or password."),
                    primaryButton: .default(Text("OK")),
                    secondaryButton: .cancel(Text("Cancel"))
                )
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(UserSession())
    }
}
