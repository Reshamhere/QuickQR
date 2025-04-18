//
//  WelcomeView.swift
//  QuickQR
//
//  Created by Resham on 20/01/25.
//

import SwiftUI

import SwiftUI

struct WelcomeView: View {
    @State private var showSignInSheet = false
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                Spacer()
                
                Image(systemName: "qrcode")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.primary)
                    .padding()
//                    .background(Circle().fill(Color.primary.opacity(0.1)))
                
                VStack {
                    Text("Welcome to \nQuickQR")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    Text("\nCreate and share QR codes effortlessly!")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                
                Spacer()
                
                // Action Button
                Button(action: {
                    showSignInSheet.toggle()
                }) {
                    Text("Let's Go")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(12)
                        .padding(.horizontal, 40)
                }
                .padding(.bottom, 20)
            }
        }
        .sheet(isPresented: $showSignInSheet) {
            SignInOptionsView()
                .presentationDetents([.height(200)])
        }
    }
}

#Preview {
    WelcomeView()
}
