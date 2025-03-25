//
//  LoginViewModel.swift
//  BasicProject
//
//  Created by Linas Venclavičius on 12/03/2025.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseAuthCombineSwift
import FirebaseFirestore

protocol AuthViewModelProtocol {
    func login(email: String, password: String) async
    func signUp(email: String, password: String, fullName: String) async
    func signOut() async
    func deleteAccount() async
    func fetchUser() async
}

@MainActor
final class AuthViewModel: AuthViewModelProtocol, ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }

    @Published var showLoginAlert = false
    @Published var errorMessage: String = .emptyString
    
    func login(email: String, password: String) async {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)

            userSession = result.user
            await fetchUser()
        } catch {
            print("Login error: \(error.localizedDescription)")
        }
    }
    
    func signUp(email: String, password: String, fullName: String) async {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            
            userSession = result.user
            let user = User(id: result.user.uid, fullName: fullName, email: email)
            
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            currentUser = user
        } catch {
            print("Signup error: \(error.localizedDescription)")
        }
    }
    
    func signOut() async {
        do {
            try Auth.auth().signOut()
            userSession = nil
            currentUser = nil
        } catch {
            print("Signout error: \(error.localizedDescription)")
        }
    }

    func deleteAccount() async {
        do {
            try await Auth.auth().currentUser?.delete()
            userSession = nil
            currentUser = nil
        } catch {
            print("User deletion error: \(error.localizedDescription)")
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
        print(currentUser?.fullName ?? "")
    }
}
