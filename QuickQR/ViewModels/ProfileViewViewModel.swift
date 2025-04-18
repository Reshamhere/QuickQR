//
//  ProfileViewViewModel.swift
//  QuickQR
//
//  Created by Resham on 09/03/25.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class ProfileViewViewModel: ObservableObject {

    @Published var user: User?
    
    func fetchUser() {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("No authenticated user found.")
            return
        }
        print("Fetching user id with: \(userID)")
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(userID)
            .getDocument { [weak self] snapshot, error in
                if let error = error {
                    print("Firestore error: \(error.localizedDescription)")
                    return
                }
                guard let data = snapshot?.data(), error == nil else {
                    return
                }
                DispatchQueue.main.async {
                    print("User data fetched. \(data)")
                    self?.user = User (
                        id: data["id"] as? String ?? "",
                        name: data["name"] as? String ?? "",
                        email: data["email"] as? String ?? "",
                        joined: data["joined"] as? TimeInterval ?? 0)
                }
            }
    }
    
    
}
