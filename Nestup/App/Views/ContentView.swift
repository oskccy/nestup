//
//  ContentView.swift
//  Nestup
//
//  Created by Oscar Spencer on 2023-08-07.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .feed
    
    enum Tab {
        case feed
        case users
    }
    
    var body: some View {
        
        TabView(selection: $selection) {
            Posts()
                .tag(Tab.feed)
                .tabItem {
                    Label("Feed", systemImage: "star")
                }

            Users()
                .tag(Tab.users)
                .tabItem {
                    Label("Users", systemImage: "list.bullet")
                }
        }
        .padding(16.0)
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
