//
//  TextFieldModifier.swift
//  Nestup
//
//  Created by Oscar Spencer on 2023-08-10.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
    content
        .font(.subheadline)
        .padding(12)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal, 24)
    }
}
