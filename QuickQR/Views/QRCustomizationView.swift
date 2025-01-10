//
//  QRCustomizationView.swift
//  QuickQR
//
//  Created by Resham on 10/01/25.
//

import SwiftUI
import QRCode

struct QRCustomizationView: View {
    @Binding var document: QRCode.Document
    
    @State private var foregroundColor: Color = .black
    @State private var backgroundColor: Color = .white
    @State private var selectedEyeStyle = 0
    @State private var selectedPixelStyle = 0
    
    private let styleNames = ["Square", "Circle", "Rounded"]
    
    private func updateEyeStyle() {
        switch selectedEyeStyle {
        case 0:
            document.design.shape.eye = QRCode.EyeShape.Square()
            document.design.shape.pupil = QRCode.PupilShape.Square()
        case 1:
            document.design.shape.eye = QRCode.EyeShape.Circle()
            document.design.shape.pupil = QRCode.PupilShape.Circle()
        case 2:
            document.design.shape.eye = QRCode.EyeShape.RoundedRect()
            document.design.shape.pupil = QRCode.PupilShape.RoundedRect()
        default:
            document.design.shape.eye = QRCode.EyeShape.Square()
            document.design.shape.pupil = QRCode.PupilShape.Square()
        }
    }
    
    private func updatePixelStyle() {
        switch selectedPixelStyle {
        case 0:
            document.design.shape.onPixels = QRCode.PixelShape.Square()
        case 1:
            document.design.shape.onPixels = QRCode.PixelShape.Circle()
        case 2:
            document.design.shape.onPixels = QRCode.PixelShape.RoundedRect()
        default:
            document.design.shape.onPixels = QRCode.PixelShape.Square()
        }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            // Colors Section
            GroupBox("Colors") {
                VStack(alignment: .leading, spacing: 12) {
                    ColorPicker("Foreground Color", selection: $foregroundColor)
                        .onChange(of: foregroundColor) {
                            updateQRCode()
                        }
                    
                    ColorPicker("Background Color", selection: $backgroundColor)
                        .onChange(of: backgroundColor) {
                            updateQRCode()
                        }
                }
                .padding(.vertical, 8)
            }
            
            // Eye Style Section
            GroupBox("Eye Style") {
                Picker("", selection: $selectedEyeStyle) {
                    ForEach(0..<styleNames.count, id: \.self) { index in
                        Text(styleNames[index]).tag(index)
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: selectedEyeStyle) {
                    updateQRCode()
                }
            }
            
            // Pixel Style Section
            GroupBox("Pixel Style") {
                Picker("", selection: $selectedPixelStyle) {
                    ForEach(0..<styleNames.count, id: \.self) { index in
                        Text(styleNames[index]).tag(index)
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: selectedPixelStyle) {
                    updateQRCode()
                }
            }
        }
        .padding()
    }
    
    private func updateQRCode() {
        // Update colors
        let cgForegroundColor = UIColor(foregroundColor).cgColor
        document.design.style.onPixels = QRCode.FillStyle.Solid(cgForegroundColor)
        document.design.style.eye = QRCode.FillStyle.Solid(cgForegroundColor)
        document.design.style.pupil = QRCode.FillStyle.Solid(cgForegroundColor)
        document.design.backgroundColor(UIColor(backgroundColor).cgColor)
        
        // Update shapes
        updateEyeStyle()
        updatePixelStyle()
    }
}

#Preview {
    QRCustomizationView(document: .constant(try! QRCode.Document(utf8String: "Preview QR Code")))
        .frame(maxWidth: 400)
}
