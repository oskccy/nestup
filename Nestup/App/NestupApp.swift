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
    @UIApplicationDelegateAdaptor private var appDelegate : AppDelegate
    
    @StateObject var userManager = UserManager()
    @StateObject var userSession = UserSession()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userSession)
                .environmentObject(userManager)
        }
    }
}
