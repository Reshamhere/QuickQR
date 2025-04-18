//
//  AuthenticationViewModel.swift
//  QuickQR
//
//  Created by Resham on 09/03/25.
//

import Foundation
import Firebase
import FirebaseAuth
import GoogleSignIn
import SwiftUI
import FirebaseFirestore

class AuthenticationViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var user: User?
    
    init() {
        self.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        print("isLoggedIn on init: \(self.isLoggedIn)")
    }

    
    func startAppFlow(completion: @escaping () -> Void) {
        fetchUser {
            completion()
        }
    }
    
    func signInWithGoogle() {
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
            let config = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.configuration = config

            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let rootViewController = windowScene.windows.first?.rootViewController else {
                return
            }

            GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { signInResult, error in
                if let error = error {
                    print("Error signing in: \(error.localizedDescription)")
                    return
                }

                guard let user = signInResult?.user, let idToken = user.idToken else {
                    print("No user or token found")
                    return
                }

                let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                               accessToken: user.accessToken.tokenString)

                Auth.auth().signIn(with: credential) { result, error in
                    if let error = error {
                        print("Firebase Sign-in failed: \(error.localizedDescription)")
                    } else {
                        self.createUser()
                        self.fetchUser {
                            print("user fetched successfully.")
                        }
                        self.isLoggedIn = true
                        UserDefaults.standard.set(true, forKey: "isLoggedIn")
                        print("User signed in: \(result?.user.displayName ?? "Unknown")")
                    }
                }
            }
    }
    
    func createUser() {
        guard let user = Auth.auth().currentUser else {
            print("Failed to fetch the current user.")
            return
        }
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(user.uid)
        
        docRef.getDocument { snapshot, error in
            if snapshot?.exists == false {
                docRef.setData([
                    "id": user.uid,
                    "name": user.displayName ?? "New User",
                    "email": user.email ?? "",
                    "joined": Date().timeIntervalSince1970
                ]) { error in
                    if let error = error {
                        print("Error create user document: \(error.localizedDescription)")
                    } else {
                        print("User document created successfully.")
                    }
                }
            }
        }
    }
    
    func fetchUser(completion: @escaping () -> Void ) {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("No authenticated user found.")
            completion()
            return
        }
        print("Fetching user id with: \(userID)")
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(userID)
            .getDocument { [weak self] snapshot, error in
                if let error = error {
                    print("Firestore error: \(error.localizedDescription)")
                    completion()
                    return
                }
                guard let data = snapshot?.data(), error == nil else {
                    print("No user data found.")
                    completion()
                    return
                }
                DispatchQueue.main.async {
                    print("User data fetched. \(data)")
                    self?.user = User (
                        id: data["id"] as? String ?? "",
                        name: data["name"] as? String ?? "",
                        email: data["email"] as? String ?? "",
                        joined: data["joined"] as? TimeInterval ?? 0)
                    self?.isLoggedIn = true
                    UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    completion()
                }
            }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            GIDSignIn.sharedInstance.signOut()
            isLoggedIn = false
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
            print("User signed out")
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
