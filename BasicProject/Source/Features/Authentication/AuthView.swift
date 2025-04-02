//
//  AuthView.swift
//  BasicProject
//
//  Created by Linas Venclavičius on 01/04/2025.
//

import SwiftUI

struct AuthView: View {
    private enum Constant {
        static let mainLabelTitle = "Spendi"
        static let mainLabelIconName = "AppIconNoBackground"
                
        static let alertButtonApproveText = "OK"
        
        static let signUpButtonTitle = "Sign Up"
        static let loginButtonTitle = "Login"
        static let noAccountText = "Don't have an account?"
        static let haveAccountText = "Already have an account?"
    }

    @Environment(AuthViewModel.self) private var viewModel

    @State private var email: String = .emptyString
    @State private var password: String = .emptyString
    
    @State private var fullName: String = .emptyString
    @State private var repeatPassword: String = .emptyString
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(Constant.mainLabelIconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundStyle(.green)
                
                Text(Constant.mainLabelTitle)
                    .foregroundStyle(.green)
                    .font(.system(size: 50, weight: .medium, design: .rounded))
                
                if viewModel.isSignUp {
                    RegistrationView(fullName: $fullName, email: $email, password: $password, confirmPassword: $repeatPassword)
                } else {
                    LoginView(email: $email, password: $password)
                }
                
                @Bindable var viewModel = viewModel
                Button {
                    Task {
                        await viewModel.authenticate(email: email, password: password, fullName: fullName)
                    }
                } label: {
                    Text(viewModel.isSignUp ? Constant.signUpButtonTitle : Constant.loginButtonTitle)
                        .frame(width: 300, height: 44)
                        .font(.title2)
                }
                .alert(viewModel.errorMessage, isPresented: $viewModel.showLoginAlert) {
                    Button(Constant.alertButtonApproveText, role: .cancel) {
                        viewModel.showLoginAlert = false
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding(.bottom, 10)
                
                Button {
                    withAnimation {
                        viewModel.isSignUp.toggle()
                    }
                } label: {
                    HStack {
                        Text(viewModel.isSignUp ? Constant.haveAccountText : Constant.noAccountText)
                        Text(viewModel.isSignUp ? Constant.signUpButtonTitle : Constant.loginButtonTitle)
                            .fontWeight(.bold)
                    }
                }
                .frame(width: 300, height: 44)
            }
        }
    }
}

#Preview {
    AuthView()
        .environment(AuthViewModel())
}
