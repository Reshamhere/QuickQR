//
//  CreateQRView.swift
//  QuickQR
//
//  Created by Resham on 04/01/25.
//

import SwiftUI
import QRCode

struct CreateQRView: View {
    
    @StateObject var scanViewVm : ScanViewViewModel = ScanViewViewModel()
    @StateObject var createQrVm: CreateQRViewViewModel = CreateQRViewViewModel()

    @State private var showContentTab = true
    @State private var isDownloadDisabled = true
    @State private var isSheetPresented = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // QR Code Preview
                VStack(spacing: 12) {
                    Text("QR code preview")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    if createQrVm.isInputValid() {
                        Image(uiImage: createQrVm.generateQRCode())
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
                        SheetView(selectedQrType: $createQrVm.selectedQrType)
                        
                        switch createQrVm.selectedQrType {
                        case .Link:
                            InputField(title: "Enter URL:",
                                       placeholder: "E.g. https://www.myweb.com/",
                                       text: $createQrVm.content)
                            { content in
                                !createQrVm.isInputValid() && !content.isEmpty ? "Invalid Url" : ""
                            }
                            
                        case .Text:
                            InputField(title: "Enter text",
                                       placeholder: "Enter your message here",
                                       text: $createQrVm.content,
                                       axis: .vertical
                            )
                            
                        case .Contact:
                            InputField(title: "Name:", text: $createQrVm.name)
 
                            InputField(title: "Phone Number:", text: $createQrVm.phoneNumber) { phoneNo in
                                !scanViewVm.isValidPhoneNumber(phoneNo) && !phoneNo.isEmpty ? "Invalid Number" : ""
                            }

                            InputField(title: "Email:", text: $createQrVm.email) { email in
                                !scanViewVm.isEmail(valid: email) && !email.isEmpty ? "Invalid email" : ""
                            }
                            
                        case .Email:
                            InputField(title: "Email address:",
                                       placeholder: "Recipient email",
                                       text: $createQrVm.email) { email in
                                !scanViewVm.isEmail(valid: email) && !email.isEmpty ? "Invalid email" : ""
                            }

                            InputField(title: "Subject", text: $createQrVm.subject, axis: .vertical)
                            
                            InputField(title: "Message", text: $createQrVm.message, axis: .vertical)
                        }
                    }
                } 
                /// Customize section
                else {
                    VStack {
                        HStack{
                            ColorPicker("Background", selection: $createQrVm.qrBgColor)
                                .padding()
                            ColorPicker("Foreground", selection: $createQrVm.qrFgColor)
                                .padding()
                        }
                        
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
                            .background(createQrVm.isInputValid() ? .blue: .gray)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    .disabled(createQrVm.isInputValid() ? false : true)
                    
                    Button(action: {}) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 25))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 30)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .padding(.bottom, 3)
                            .background(createQrVm.isInputValid() ? .blue: .gray)
                            .cornerRadius(100)
                    }
                    .padding(.trailing, 5)
                    .disabled(createQrVm.isInputValid() ? false : true)
                    
                    Button(action: {}) {
                        Image(systemName: "bookmark")
                            .font(.system(size: 25))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 30)
                            .padding(8.5)
                            .background(createQrVm.isInputValid() ? .blue: .gray)
                            .cornerRadius(100)
                    }
                    .padding(.trailing, 5)
                    .disabled(createQrVm.isInputValid() ? false : true)
                    
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    CreateQRView()
}
