//
//  MainView.swift
//  QuickQR
//
//  Created by Resham on 10/04/25.
//

import SwiftUI

struct MainView: View {
//    @AppStorage("isLoggedIn") private var isLoggedIn = false
//    @StateObject var AuthVM = AuthenticationViewModel()
    @EnvironmentObject var AuthVM : AuthenticationViewModel
    
    var body: some View {
        if AuthVM.isLoggedIn {
            ContentView()
        } else {
            WelcomeView()
        }
    }
}

#Preview {
    MainView()
        .environmentObject(AuthenticationViewModel())
}
