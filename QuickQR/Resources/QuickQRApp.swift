//
//  QuickQRApp.swift
//  QuickQR
//
//  Created by Resham on 12/12/24.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
                        FirebaseApp.configure()
                        return true
                    }
}

@main
struct QuickQRApp: App {
    @StateObject var authVM = AuthenticationViewModel()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
           SplashScreenView()
                .environmentObject(authVM)
        }
    }
}
