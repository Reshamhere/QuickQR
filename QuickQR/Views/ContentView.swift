//
//  ContentView.swift
//  QuickQR
//
//  Created by Resham on 12/12/24.
//

import SwiftUI

struct ContentView: View {
    let bgColor = Color(red: 249/255, green: 250/255, blue: 251/255)
    
    @State private var selection = 1
    
    var body: some View {
        NavigationStack {
            ZStack {
                bgColor
                    .ignoresSafeArea()
                
                switch selection {
                case 1:
                    HomeView()
                case 2:
                    ScanView()
                case 3:
                    HistoryView()
                default:
                    HomeView()
                }
                
                TabView(selection: $selection)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    ContentView()
}
