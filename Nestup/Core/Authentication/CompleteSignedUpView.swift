//
//  CompleteSignedUpView.swift
//  Nestup
//
//  Created by Oscar Spencer on 2023-08-10.
//

import SwiftUI

struct CompleteSignedUpView: View {
    @State private var email = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 12) {
            
            Spacer()
            
            Text("Welcome do Nestup, aaron.arellano!")
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
              print("Complete sign up")
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
    }
}

struct CompleteSignedUpView_Previews: PreviewProvider {
    static var previews: some View {
        CompleteSignedUpView()
    }
}
