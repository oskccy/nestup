//
//  PostTextField.swift
//  Nestup
//
//  Created by Aaron Arellano on 2023-08-25.
//

import SwiftUI

struct PostTextField: ViewModifier {
    func body(content: Content) -> some View {
    content
        .padding(.horizontal)
        .foregroundColor(.black)
        .autocapitalization(.none)
        .disableAutocorrection(true)
        .multilineTextAlignment(.center)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
            .stroke(.gray, lineWidth: 1)
        )
    }
}
