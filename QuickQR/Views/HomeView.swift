//
//  HomeView.swift
//  QuickQR
//
//  Created by Resham on 16/12/24.
//

import SwiftUI

struct HomeView: View {
    let subTitle = Color(red: 75/255, green: 85/255, blue: 99/255)
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("QuickQR")
                    .font(.system(size: 40).bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .padding(.top, 20)
                
                Text("Create and scan OR codes instantly")
                    .font(.title2)
                    .foregroundStyle(subTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .padding(.bottom, 20)
                
                HStack {
                    NavigationLink {

                    } label: {
                        VStack{
                            Image(systemName: "qrcode")
                                .padding(10)
                                .background(.blue.opacity(0.1))
                                .cornerRadius(100)
                                .font(.system(size: 30))
                            Text("Create QR")
                                .foregroundStyle(.black)
                                .fontWeight(.medium)
                        }
                        .frame(width: 180, height: 120)
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: .black.opacity(0.1), radius: 1, x: -1, y: 1)
                        .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: -1)
                        //                    .scaleEffect(scale ? 0.9 : 1)
                    }
                    
                    
                    NavigationLink {
                        // Scan QR
                        ScanView()
                    } label: {
                        VStack{
                            Image(systemName: "qrcode")
                                .padding(10)
                                .background(.blue.opacity(0.1))
                                .cornerRadius(100)
                                .font(.system(size: 30))
                            
                            Text("Scan Code")
                                .foregroundStyle(.black)
                                .fontWeight(.medium)
                        }
                        .frame(width: 180, height: 120)
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: .black.opacity(0.1), radius: 1, x: -1, y: 1)
                        .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: -1)
                    }
                    
                    
                } // End of Hstack
                .padding(.top, 10)
                
                VStack {
                    Text("Recent Codes")
                        .font(.system(size: 20).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .padding(.top, 20)
                }
                Spacer()
            } // End of Vstack
        }
    }
}

#Preview {
    HomeView()
}
