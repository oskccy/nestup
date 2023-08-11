//
//  FeedView.swift
//  Nestup
//
//  Created by Oscar Spencer on 2023-08-09.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack (spacing: 32) {
                    ForEach(0 ... 10, id:\.self) {
                        post in FeedCell()
                    }
                }
                .padding(.top, 8)
            }
            .navigationTitle("Feed")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("nestup-transparent")
                        .resizable()
                        .frame(width: 100, height: 65)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                }
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
