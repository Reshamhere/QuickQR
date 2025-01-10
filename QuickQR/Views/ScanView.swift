//
//  ScanView.swift
//  QuickQR
//
//  Created by Resham on 19/12/24.
//

import SwiftUI
//import AVFoundation
import CodeScanner
import AlertToast

struct ScanView : View {
    
    @StateObject var viewmodel : ScanViewViewModel = ScanViewViewModel()
    
    @State var isPresentingScanner = false
    @State var isPresentingAlert = false
//    @State var alertMessage: String = ""
    @State var scannedCode: String = "Scan a QR code to get started!"
    
//    @State var copied : Bool = false

    
    var scannerSheet : some View {
        CodeScannerView(
            codeTypes: [.qr]) { result in
                if case let .success(code) = result {
                    self.scannedCode = code.string
                    self.isPresentingScanner = false
                    self.isPresentingAlert = true
                }
            }
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("Position your code within the frame")
                .padding(10)

            VStack {
                self.scannerSheet
            }
            .padding()
            .frame(height: 500)
            .cornerRadius(30)
            
            
            Button("Scan QR code") {
                isPresentingScanner = true
            }
            .alert(isPresented: $isPresentingAlert, content: {
                Alert(title: Text("alert"),
                      message: Text(scannedCode),
                      primaryButton: viewmodel.isValidUrl(scannedCode) ? .default(Text("Open"), action: {viewmodel.openURL(scannedCode)}) : .default(Text("Copy"), action: {viewmodel.copytoClipboard(scannedCode)}),
                      secondaryButton: .default(Text("Copy"), action: {viewmodel.copytoClipboard(scannedCode)})
                )
            })
            .toast(isPresenting: $viewmodel.copied) {
                AlertToast(displayMode: .hud, type: .regular, title: "Copied to Clipboard")
            }
            
            Spacer()
            Spacer()
        }
        
    }
}

#Preview {
    ScanView()
}
