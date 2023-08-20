//
//  NestupApp.swift
//  Nestup
//
//  Created by Oscar Spencer on 2023-08-07.
//

import SwiftUI
import Firebase

@main
struct NestupApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(UserSession())
        }
    }
}
