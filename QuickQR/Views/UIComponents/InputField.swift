//
//  InputField.swift
//  QuickQR
//
//  Created by Resham on 15/01/25.
//

import SwiftUI

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

#Preview {
    InputField(text: .constant(" "))
}
