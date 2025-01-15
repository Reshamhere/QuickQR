//
//  CreateQRViewViewModel.swift
//  QuickQR
//
//  Created by Resham on 15/01/25.
//

import Foundation
import SwiftUI
import QRCode

class CreateQRViewViewModel: ObservableObject {
    
    @Published var scanViewVm : ScanViewViewModel = ScanViewViewModel()
    
    @Published var content: String = ""
    
    @Published var selectedQrType : QrTypes = .Link
    @Published var name: String = ""
    @Published var phoneNumber: String = ""
    @Published var email: String = ""
    @Published var subject: String = ""
    @Published var message: String = ""
    
    @Published var qrBgColor: Color = .white
    @Published var qrFgColor: Color = .black
    
    func generateQRCode() -> UIImage {
        do {
            let qrString = qrContent()
            let document = try QRCode.Document(utf8String: qrString)

            let bgColor = qrBgColor.cgColorRepresentation ?? CGColor(red: 1, green: 1, blue: 1, alpha: 1) // White
            let fgColor = qrFgColor.cgColorRepresentation ?? CGColor(red: 0, green: 0, blue: 0, alpha: 1) // Black
            
            document.design.backgroundColor(bgColor)
            document.design.foregroundColor(fgColor)
            
            let cgImage = try document.cgImage(dimension: 400)
            
            return UIImage(cgImage: cgImage)
        } catch {
            print("Error generating QR code: \(error)")
            return UIImage()
        }
    }
    
    func isInputValid( ) -> Bool {
        switch selectedQrType {
        case .Link:
            return scanViewVm.isValidUrl(content)
        case .Text:
            return !content.isEmpty
        case .Contact:
            if name.isEmpty {
                return false
            }
            if phoneNumber.isEmpty && email.isEmpty {
                return false
            }
            let isEmailValid = email.isEmpty ? true : scanViewVm.isEmail(valid: email)
            let isPhoneNumberValid = phoneNumber.isEmpty ? true : scanViewVm.isValidPhoneNumber(phoneNumber)

            return isEmailValid && isPhoneNumberValid
            
        case .Email:
            return scanViewVm.isEmail(valid: email)
        }
    }
    
    func qrContent() -> String {
        switch selectedQrType {
        case .Link:
            return content
        case .Text:
            return content
        case .Contact:
            return "Name : \(name) \n Phone Number: \(phoneNumber) \n Email: \(email)"
        case .Email:
            let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let encodedMessage = message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return "mailto:\(email)?subject=\(encodedSubject)&body=\(encodedMessage)"
        }
    }
}
