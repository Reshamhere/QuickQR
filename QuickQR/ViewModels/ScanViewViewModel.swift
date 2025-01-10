//
//  ScanViewViewModel.swift
//  QuickQR
//
//  Created by Resham on 08/01/25.
//

import Foundation
import SwiftUI

class ScanViewViewModel: ObservableObject {
    
    @Published var alertMessage: String = ""
    @Published var copied : Bool = false
    @Published var errorMessage: String = ""
    
    func isValidUrl(_ str : String) -> Bool {
        guard let url = URL(string: str) else {
            return false
        }
        return UIApplication.shared.canOpenURL(url)
    }
    
    func openURL(_ urlString : String) {
        guard let url = URL(string: urlString), UIApplication.shared.canOpenURL(url)
        else {
            return
        }
        UIApplication.shared.open(url)
    }
    
    func copytoClipboard(_ str : String) {
        UIPasteboard.general.string = str
        copied = true
        
    }
    
    func isEmail(valid: String) -> Bool {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let isValid = NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: valid)
        return isValid
    }
    
    
    func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        let phoneFormat1 = "^\\d{3}-\\d{3}-\\d{4}$" // XXX-XXX-XXXX
        let phoneFormat2 = "^\\d{10}$" // XXXXXXXXXX
        let regex1 = try! NSRegularExpression(pattern: phoneFormat1, options: [])
        let regex2 = try! NSRegularExpression(pattern: phoneFormat2, options: [])
        let range = NSRange(phoneNumber.startIndex..<phoneNumber.endIndex, in: phoneNumber)
        let result1 = regex1.firstMatch(in: phoneNumber, options: [], range: range)
        let result2 = regex2.firstMatch(in: phoneNumber, options: [], range: range)
        return result1 != nil || result2 != nil
    }
}
