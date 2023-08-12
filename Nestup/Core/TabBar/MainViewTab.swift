//
//  MainViewTab.swift
//  Nestup
//
//  Created by Oscar Spencer on 2023-08-09.
//

import SwiftUI

struct MainViewTab: View {
    var body: some View {
        TabView {
            FeedView()
                .tabItem {
                    Image(systemName: "house")
                }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            Text("Upload Post")
                .tabItem {
                    Image(systemName: "plus.square")
                }
            Text("Notifications")
                .tabItem {
                    Image(systemName: "heart")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                }
        }
        .accentColor(.black)
    }
}

struct MainViewTab_Previews: PreviewProvider {
    static var previews: some View {
        MainViewTab()
    }
}
