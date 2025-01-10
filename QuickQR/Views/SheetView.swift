//
//  SwiftUIView.swift
//  QuickQR
//
//  Created by Resham on 08/01/25.
//

import SwiftUI

struct SheetView: View {
    
    @Binding var selectedQrType : QrTypes
    @State private var isSheetPresented = false
    
    var body: some View {
        Group {
            Button {
                isSheetPresented = true
            } label: {
                HStack {
                    selectedQrType.icon
                        .font(.system(size: 20).bold())
                        .tint(.blue)
                        .padding(.leading, 10)
                        
                    Text(selectedQrType.rawValue)
                        .font(.system(size: 20).bold())
                        
                    Spacer()
                    Image(systemName: "chevron.down")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(.trailing, 10)
                }
            }
            .sheet(isPresented: $isSheetPresented) {
                Text("Select a QR Type")
                    .font(.system(size: 20).bold())
                    .padding(.top, 40)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                
                List {
                    ForEach(QrTypes.allCases) { QrType in
                        Button{
                            selectedQrType = QrType
                            isSheetPresented = false
                        } label: {
                            HStack {
                                QrType.icon
                                    .foregroundStyle(.blue)
                                    .padding(10)
                                    .background(.gray.opacity(0.1))
                                    .cornerRadius(15)
                                
                                Text(QrType.rawValue)
                                    .font(.system(size: 22))
                            }
                        }
                        .foregroundStyle(.black.opacity(0.8))
                        .fontWeight(.semibold)
//                        .listRowSeparator(.hidden)
                        
                    }
                }
                .padding(.horizontal)
                .listStyle(.plain)
                .presentationDetents([.height(300)])
//                .presentationDragIndicator(.visible)
                .scrollIndicators(.hidden)
                
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.blue.opacity(0.1))
            .cornerRadius(10)
        }
        .padding(.horizontal)
    }
}

#Preview {
    SheetView(selectedQrType: .constant(.Link))
}
