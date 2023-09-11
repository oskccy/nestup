//
//  SearchView.swift
//  Nestup
//
//  Created by Oscar Spencer on 2023-08-09.
//

import SwiftUI

struct SearchView: View {
    @State private var searchManager: SearchManager = SearchManager()
    @State private var searchText = ""
    @State private var query = [String]()
    @State private var queryPosts : [Post] = []
    
    var body: some View {
        NavigationStack {
            Button {
                query = searchManager.getQuery(searchText.lowercased())
                searchManager.searchPosts(query) { results, error in
                    if error != nil {
                        //alert
                    } else {
                        queryPosts = results ?? []
                    }
                }
            } label: {
                Text("Search")
                    .padding()
                    .frame(width: 300, height: 30)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray, lineWidth: 1)
                    )
                    .background(.blue)
                    .cornerRadius(100)
            }
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(queryPosts, id: \.self) { post in
                        NavigationLink(destination:
                                ScrollView {
                            PostView(post:post)
                                }
                            ){
                            PostCell(post:post)
                            }
                            .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.top, 8)
                .searchable(text: $searchText, prompt: "Search...")
                .onChange(of: searchText) { searchText in
                    
                }
            }
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
