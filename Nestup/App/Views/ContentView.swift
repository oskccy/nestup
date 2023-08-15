//
//  ContentView.swift
//  Nestup
//
//  Created by Oscar Spencer on 2023-08-07.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .feed
    private let userId: Int = 1
    
    enum Tab {
        case feed
        case search
        case profile
    }
    
    var body: some View {
        
        TabView(selection: $selection) {
            FeedView()
                .tag(Tab.feed)
                .tabItem {
                    Label("Feed", systemImage: "star")
                }
            
            SearchView()
                .tag(Tab.search)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            ProfileView(user: users[userId])
                .tag(Tab.profile)
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        .padding(.vertical, 16.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
