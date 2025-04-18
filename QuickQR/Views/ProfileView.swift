//
//  ProfileView.swift
//  QuickQR
//
//  Created by Resham on 09/03/25.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel : AuthenticationViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if let user = viewModel.user {
                    profile(user: user)
                } else {
                    Text("Loading Profile...")
                }
            }
            .navigationTitle("Profile")
        }
//        .onAppear {
//            viewModel.fetchUser()
//        }
    
    } // end of body
    
    @ViewBuilder
    func profile(user: User) -> some View {
        // Avatar
        
        // Info
        VStack(alignment: .leading) {
            HStack {
                Text("Name: ").bold()
                Text(user.name)
            }
            .padding()
            HStack {
                Text("Email: ").bold()
                Text(user.email)
            }
            .padding()
            HStack {
                Text("Member Since: ").bold()
                Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
            }
            .padding()
        }
        .padding()
        
        Button {
            viewModel.signOut()
        } label: {
            Text("Log Out")
                .font(.system(size: 20))
                .bold()
                .foregroundStyle(.white)
                .frame(width: 180, height: 50)
                .background(.blue)
                .cornerRadius(30)
                .padding()
        }
    }
}



#Preview {
    ProfileView()
        .environmentObject(AuthenticationViewModel())
}
