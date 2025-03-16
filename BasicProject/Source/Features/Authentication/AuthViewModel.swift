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

protocol AuthViewModelProtocol {
    func login() async
    func signUp() async
    func signOut()
    func deleteAccount()
    func fetchUser() async
}

final class AuthViewModel: AuthViewModelProtocol, ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    @Published var fullName: String = .emptyString
    @Published var email: String = .emptyString
    @Published var password: String = .emptyString

    @Published var showLoginAlert = false
    @Published var errorMessage: String = .emptyString
    
    func login() async {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            DispatchQueue.main.async {
                self.errorMessage = "Logged in successfully \nEmail: \(result.user.email ?? .emptyString)"
                self.showLoginAlert = true
                self.clearTextFields()
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
                self.showLoginAlert = true
            }
            
        }
    }
    
    func signUp() async {
        do {
            try await Auth.auth().createUser(withEmail: email, password: password)
            DispatchQueue.main.async {
                self.errorMessage = "User created successfully\nPlease login"
                self.showLoginAlert = true
                self.clearTextFields()
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
                self.showLoginAlert = true
            }
        }
    }
    
    func signOut() {
        
    }

    func deleteAccount() {
        
    }

    func fetchUser() async {
        
    }
}

private extension AuthViewModel {
    func clearTextFields() {
        fullName = .emptyString
        email = .emptyString
        password = .emptyString
    }
}
