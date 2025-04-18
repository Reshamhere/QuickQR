//
//  SignInOptionsView.swift
//  QuickQR
//
//  Created by Resham on 09/03/25.
//

import SwiftUI

struct SignInOptionsView: View {
//    @StateObject var AuthVm: AuthenticationViewModel = AuthenticationViewModel()
    @EnvironmentObject var AuthVm : AuthenticationViewModel
    
    var body: some View {
        Text("Sign In Options")
            .font(.headline)
            .padding()
        Button{
            AuthVm.signInWithGoogle()
        } label: {
            Image("search")
                .resizable()
                .frame(width: 25, height: 25)
                .padding(.leading, 20)
            Text("Sign in with Google")
                .font(.system(size: 20).bold())
                .foregroundStyle(.white)
                .padding()
        }
        .frame(width: 270)
        .background(.black)
        .cornerRadius(12)
        
        Button{
            
        } label: {
            Image("apple-logo")
                .resizable()
                .frame(width: 25, height: 25)
                .padding(.leading, 20)
            Text("Sign in with Apple")
                .font(.system(size: 20).bold())
                .foregroundStyle(.white)
                .padding()
        }
        .frame(width: 270)
        .background(.black)
        .cornerRadius(12)
    }
}

#Preview {
    SignInOptionsView()
        .environmentObject(AuthenticationViewModel())
}
