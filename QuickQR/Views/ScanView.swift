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
    
    @State var isPresentingScanner = false
    @State var isPresentingAlert = false
    @State var alertMessage: String = ""
    @State var scannedCode: String = "Scan a QR code to get started!"
    
    @State var copied : Bool = false

    
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
                      primaryButton: isValidUrl(scannedCode) ? .default(Text("Open"), action: {openURL(scannedCode)}) : .default(Text("Copy"), action: {copytoClipboard(scannedCode)}),
                      secondaryButton: .default(Text("Copy"), action: {copytoClipboard(scannedCode)})
                )
            })
            .toast(isPresenting: $copied) {
                AlertToast(displayMode: .hud, type: .regular, title: "Copied to Clipboard")
            }
            
            Spacer()
            Spacer()
        }
        
    }
    
    func isValidUrl(_ str : String) -> Bool {
        guard let url = URL(string: str) else {
            return false
        }
        return UIApplication.shared.canOpenURL(url)
    }
    
    func openURL(_ urlString : String) {
        guard let url = URL(string: urlString), UIApplication.shared.canOpenURL(url)
        else {
            alertMessage = "Invalid URL"
            return
        }
        UIApplication.shared.open(url)
    }
    
    func copytoClipboard(_ str : String) {
        UIPasteboard.general.string = str
        copied = true
        
    }
}

#Preview {
    ScanView()
}
