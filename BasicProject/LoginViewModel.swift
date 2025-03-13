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

protocol LoginViewModelProtocol {
    func login()
}

final class LoginViewModel: LoginViewModelProtocol, ObservableObject {
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var username = ""
    @Published var password = ""

    @Published var showLoginAlert = false
    @Published var errorMessage: String = ""
    
    @Published var user: String?

    
    func login() {
//        Auth.auth().signIn { [weak self] result, error in
//            guard let self else { return }
//            
//            if let result {
//                print("The user signed in: \(result.user.email ?? "-")")
//            } else {
//                self.errorMessage = error?.localizedDescription ?? "Error creating user"
//                self.showLoginAlert = true
//            }
//        }
        
//        Auth.auth().signIn(withEmail: username, password: password)
        
//        Auth.auth()
//            .signIn(withEmail: username, password: password)
//            .sink(receiveCompletion: { [weak self] result in
//                switch result {
//                case .finished:
//                    self?.moveToNextView()
//                case .failure(let error):
//                    self?.errorMessage = error.localizedDescription
//                    self?.showLoginAlert = true
//                }
//            }, receiveValue: { [weak self] value in
//                self?.user = value.user.email
//                self?.errorMessage = self?.user ?? "Login successful"
//                self?.showLoginAlert = true
//            })
//            .store(in: &subscriptions)

        
    }
    
    func moveToNextView() {
        
    }
    
}
