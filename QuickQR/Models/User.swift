//
//  User.swift
//  QuickQR
//
//  Created by Resham on 09/03/25.
//

import Foundation

struct User : Codable, Identifiable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
//    var photoURL : URL?
}

/// why is it codable -> because it should be json readable
