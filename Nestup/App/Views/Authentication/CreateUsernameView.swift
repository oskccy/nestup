//
//  CreateUsernameView.swift
//  Nestup
//
//  Created by Oscar Spencer on 2023-08-10.
//

import SwiftUI

struct CreateUsernameView: View {
    @EnvironmentObject var createUser : CreateUser
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 12) {
            Text("Create username")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            Text("This username will be your display name.")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            TextField("Username", text: $createUser.username)
                .autocapitalization(.none)
                .modifier(TextFieldModifier())
                .disableAutocorrection(true)
            
            NavigationLink {
                CreatePasswordView()
                    .environmentObject(createUser)
                    .navigationBarBackButtonHidden(true)
            } label: {
                Text("Next")
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
    }
}

struct CreateUsernameView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUsernameView().environmentObject(CreateUser())
    }
}
