//
//  LoginViewModel.swift
//  BasicProject
//
//  Created by Linas Venclavičius on 12/03/2025.
//

import Foundation
import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

protocol AuthViewModelProtocol {
    func authenticate(email: String, password: String, fullName: String) async
    func signOut() async
    func deleteAccount() async
}

@MainActor
@Observable class AuthViewModel: AuthViewModelProtocol {
    
    // MARK: - Published variables

    var userSession: FirebaseAuth.User? {
        didSet {
            if let userSession {
                isLoggedIn = true
            } else {
                isLoggedIn = false
            }
        }
    }
    
    var currentUser: User?
    var isLoading = true
    var isLoggedIn = false
    var isSignUp = false
    
    var showLoginAlert = false
    var errorMessage: String = .emptyString
    
    // MARK: - Initializer

    init() {
        Task {
            await initialCheckIfLoggedIn()
        }
    }
    
    // MARK: - Public functionality

    func authenticate(email: String, password: String, fullName: String) async {
        if isSignUp {
            await signUp(email: email, password: password, fullName: fullName)
        } else {
            await login(email: email, password: password)
        }
    }
    
    func signOut() async {
        defer {
            isLoading = false
        }
        
        do {
            isLoading = true
            try Auth.auth().signOut()
            
            userSession = nil
            currentUser = nil
        } catch {
            print("Signout error: \(error.localizedDescription)")
        }
    }

    func deleteAccount() async {
        defer {
            isLoading = false
        }
        
        do {
            isLoading = true
            try await Auth.auth().currentUser?.delete()
            
            userSession = nil
            currentUser = nil
        } catch {
            print("User deletion error: \(error.localizedDescription)")
        }
    }
}

// MARK: - Private functionality

private extension AuthViewModel {
    func login(email: String, password: String) async {
        defer {
            isLoading = false
        }
        
        do {
            isLoading = true
            let result = try await Auth.auth().signIn(withEmail: email, password: password)

            userSession = result.user
            await fetchUser()
        } catch {
            print("Login error: \(error.localizedDescription)")
        }
    }
    
    func signUp(email: String, password: String, fullName: String) async {
        defer {
            isLoading = false
        }
        
        do {
            isLoading = true
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            
            let user = User(id: result.user.uid, fullName: fullName, email: email)
            
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            
            userSession = result.user
            currentUser = user
        } catch {
            print("Signup error: \(error.localizedDescription)")
        }
    }
    
    func fetchUser() async {
        guard
            let uid = Auth.auth().currentUser?.uid,
            let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument()
        else {
            return
        }
        
        currentUser = try? snapshot.data(as: User.self)
    }
    
    func initialCheckIfLoggedIn() async {
        defer {
            isLoading = false
        }
        
        userSession = Auth.auth().currentUser
        if userSession != nil {
            await fetchUser()
        }
    }
}
