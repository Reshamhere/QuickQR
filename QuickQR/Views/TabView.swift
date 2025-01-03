//
//  TabView.swift
//  QuickQR
//
//  Created by Resham on 20/12/24.
//

import SwiftUI

struct TabView: View {
    @Binding var selection:Int
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Button{
//                Home
                    selection = 1
                } label: {
                    Image(systemName: "house")
                        .font(.system(size: 25))
                        .foregroundStyle(selection == 1 ? .blue : .gray)
                }
                Text("Home")
                    .font(.system(size: 14))
                    .padding(.top, 1)
                    .foregroundStyle(selection == 1 ? .blue : .gray)
                    
            }
            
            Spacer()
            
            VStack {
                NavigationLink {
                    ScanView()
                } label: {
                    Image(systemName: "qrcode.viewfinder")
                        .font(.system(size: 25))
                        .foregroundStyle(selection == 2 ? .blue : .gray)
                }
                .onTapGesture {
                    selection = 2
                }
                
                Text("Scan")
                    .font(.system(size: 14))
                    .padding(.top, 1)
                    .foregroundStyle(selection == 2 ? .blue : .gray)
            }
            
            Spacer()
            
            VStack {
                Button{
//                History
                    selection = 3
                } label: {
                    Image(systemName: "clock.arrow.circlepath")
                        .font(.system(size: 25))
                        .foregroundStyle(selection == 3 ? .blue : .gray)
                }
                Text("History")
                    .font(.system(size: 14))
                    .padding(.top, 1)
                    .foregroundStyle(selection == 3 ? .blue : .gray)
            }
            Spacer()
            
        } /// End of HStack
        .padding()
        .padding(.bottom, 10)
        .background(.white)
        .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.gray.opacity(0.4)),
                alignment: .top
        )
    }
}

#Preview {
    TabView(selection: .constant(1))
}
