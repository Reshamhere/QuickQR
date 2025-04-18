//
//  SplashScreenView.swift
//  QuickQR
//
//  Created by Resham on 13/04/25.
//

import SwiftUI
import Lottie

struct SplashScreenView: View {
    @EnvironmentObject var vm : AuthenticationViewModel
    
    @State var isActive: Bool = false
    @State var size : Double = 0.8
    @State var opacity : Double = 0.0
    @State var y_offset : CGFloat = 50
    
    var body: some View {
        if isActive {
            MainView()
        } else {
            VStack {
                VStack {
                    Image(systemName: "qrcode")
                        .font(.system(size: 100))
                        .foregroundStyle(.indigo)
                        .scaleEffect(size)
                        .offset(y : y_offset)
                        .onAppear {
                            withAnimation(.easeIn(duration: 1.2)) {
                                self.size = 1
                                self.y_offset = 0
                            }
                        }
                    Text("QuickQR")
                        .font(.system(size: 48))
                        .bold()
                        .opacity(opacity)
                        .onAppear {
                            withAnimation(.easeIn(duration: 2.2).delay(0.8)) {
                                self.opacity = 1
                            }
                        }
                }
            }
            .onAppear {
                vm.startAppFlow {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
        .environmentObject(AuthenticationViewModel())
}
