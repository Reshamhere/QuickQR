//
//  QrType.swift
//  QuickQR
//
//  Created by Resham on 08/01/25.
//

import Foundation
import SwiftUI

enum QrTypes: String, CaseIterable, Identifiable {
    case Link, Text, Contact, Email
    
    var id: Self {self}
    
    var icon: Image {
            switch self {
            case .Link:
                return Image(systemName: "link")
            case .Text:
                return Image(systemName: "text.bubble")
            case .Contact:
                return Image(systemName: "person.crop.circle")
            case .Email:
                return Image(systemName: "envelope")
            }
        }
}
