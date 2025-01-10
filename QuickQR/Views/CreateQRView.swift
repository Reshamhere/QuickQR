//
//  CreateQRView.swift
//  QuickQR
//
//  Created by Resham on 04/01/25.
//

import SwiftUI
import QRCode

struct CreateQRView: View {
    
    @StateObject var viewmodel : ScanViewViewModel = ScanViewViewModel()

    @State private var content: String = ""
    @State private var showContentTab = true
    @State private var isDownloadDisabled = true
    @State private var isSheetPresented = false
    
    @State private var selectedQrType : QrTypes = .Link
    
    @State private var name: String = ""
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    @State private var subject: String = ""
    @State private var message: String = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // QR Code Preview
                VStack(spacing: 12) {
                    Text("QR code preview")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    if isInputValid() {
                        Image(uiImage: generateQRCode())
                            .resizable()
                            .scaledToFit()
                            .padding(20)
                            .frame(width: 250, height: 250)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 5)
                    } else {
                        Image("qr 1")
                            .resizable()
                            .scaledToFit()
                            .padding(40)
                            .frame(width: 250, height: 250)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 5)
                    }
                }
                
                // Content & Design Buttons
                HStack(spacing: 20) {
                    Button {
                        withAnimation {
                            showContentTab = true
                        }
                    } label: {
                        Text("Create")
                            .fontWeight(.semibold)
                            .foregroundColor(showContentTab ? .white : .blue)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(showContentTab ? Color.blue : Color.blue.opacity(0.2))
                            .cornerRadius(10)
                    }
                    
                    Button {
                        withAnimation {
                            showContentTab = false
                        }
                    } label: {
                        Text("Customize")
                            .fontWeight(.semibold)
                            .foregroundColor(!showContentTab ? .white : .blue)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(!showContentTab ? Color.blue : Color.blue.opacity(0.2))
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                
                // Content Tab
                if showContentTab {
                    VStack(alignment: .leading, spacing: 10) {
                        SheetView(selectedQrType: $selectedQrType)
                        
                        switch selectedQrType {
                        case .Link:
                            InputField(title: "Enter URL:",
                                       placeholder: "E.g. https://www.myweb.com/",
                                       text: $content) 
                            { content in
                                !isInputValid() && !content.isEmpty ? "Invalid Url" : ""
                            }
                            
                        case .Text:
                            InputField(title: "Enter text",
                                       placeholder: "Enter your message here",
                                       text: $content,
                                       axis: .vertical
                            )
                            
                        case .Contact:
                            InputField(title: "Name:", text: $name)
 
                            InputField(title: "Phone Number:", text: $phoneNumber) { phoneNo in
                                !viewmodel.isValidPhoneNumber(phoneNo) && !phoneNo.isEmpty ? "Invalid Number" : ""
                            }

                            InputField(title: "Email:", text: $email) { email in
                                !viewmodel.isEmail(valid: email) && !email.isEmpty ? "Invalid email" : ""
                            }
                            
                        case .Email:
                            InputField(title: "Email address:",
                                       placeholder: "Recipient email",
                                       text: $email) { email in
                                !viewmodel.isEmail(valid: email) && !email.isEmpty ? "Invalid email" : ""
                            }

                            InputField(title: "Subject", text: $subject, axis: .vertical)
                            
                            InputField(title: "Message", text: $message, axis: .vertical)
                        }
                    }
                } 
                /// Customize section
                else {
                    VStack {
                        
                    }
                }
                
                HStack {
                    // Download Button (Disabled for now)
                    Button(action: {}) {
                        Text("Download QR")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(isInputValid() ? .blue: .gray)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    .disabled(isInputValid() ? false : true)
                    
                    Button(action: {}) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 25))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 30)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .padding(.bottom, 3)
                            .background(isInputValid() ? .blue: .gray)
                            .cornerRadius(100)
                    }
                    .padding(.trailing, 5)
                    .disabled(isInputValid() ? false : true)
                }
                
                Spacer()
            }
            .padding()
        }
    }

    private func generateQRCode() -> UIImage {
        do {
            let qrString = qrContent()
             let document = try QRCode.Document(utf8String: qrString)
            let cgImage = try document.cgImage(dimension: 400)
            return UIImage(cgImage: cgImage)
        } catch {
            print("Error generating QR code: \(error)")
            return UIImage()
        }
    }
    
    private func qrContent() -> String {
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
    
    func isInputValid( ) -> Bool {
        switch selectedQrType {
        case .Link:
            return viewmodel.isValidUrl(content)
        case .Text:
            return !content.isEmpty
        case .Contact:
            if name.isEmpty {
                return false
            }
            if phoneNumber.isEmpty && email.isEmpty {
                return false
            }
            let isEmailValid = email.isEmpty ? true : viewmodel.isEmail(valid: email)
            let isPhoneNumberValid = phoneNumber.isEmpty ? true : viewmodel.isValidPhoneNumber(phoneNumber)

            return isEmailValid && isPhoneNumberValid
            
        case .Email:
            return viewmodel.isEmail(valid: email)
        }
    }
}

#Preview {
    CreateQRView()
}



struct InputField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    let axis: Axis
    let validation: (String) -> String
    
    init(title: String = "", placeholder: String = "", text: Binding<String>, axis : Axis = .vertical, _ validation: @escaping (String) -> String = { _ in "" }) {
        self.title = title
        self.placeholder = placeholder
        self._text = text
        self.axis = axis
        self.validation = validation
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                if !title.isEmpty {
                    Text(title)
                        .font(.system(size: 18))
                        .padding(.horizontal)
                        .padding(.top, 10)
                }
                Spacer()
                Text(validation(text))
                    .font(.system(size: 16))
                    .foregroundStyle(.red)
                    .padding(.horizontal)
                    .padding(.top, 10)
                
            }
            TextField(placeholder, text: $text, axis: axis)
                .textInputAutocapitalization(.never)
                .font(.system(size: 18))
                .padding(.horizontal)
                .frame(width: .infinity, height: 40)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.7), lineWidth: 1))
                .padding(.horizontal)
            
        }
    }
}
