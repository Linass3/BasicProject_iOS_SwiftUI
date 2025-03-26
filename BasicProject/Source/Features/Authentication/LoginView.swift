//
//  LoginView.swift
//  BasicProject
//
//  Created by Linas Venclavičius on 05/03/2025.
//

import SwiftUI

struct LoginView: View {
    private enum Constant {
        static let mainLabelTitle = "MyApp"
        static let mainLabelIconName = "bolt.fill"
        
        static let emailPlaceholder = "Email address"
        static let emailTextfieldIconName = "at"
        
        static let passwordPlaceholder = "Password"
        static let passwordTextfieldIconName = "key.fill"
        
        static let loginButtonTitle = "Login"
        
        static let alertButtonApproveText = "OK"
    }

    @EnvironmentObject private var viewModel: AuthViewModel
    
    @State private var email: String = .emptyString
    @State private var password: String = .emptyString
    
    var body: some View {
        NavigationStack {
            VStack {
                Label(Constant.mainLabelTitle, systemImage: Constant.mainLabelIconName)
                    .foregroundStyle(
                        .linearGradient(Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing)
                    )
                    .font(.system(size: 40, weight: .medium, design: .rounded))
                                
                LoginTextField(
                    text: $email,
                    placeholder: Constant.emailPlaceholder,
                    secureTextEntry: false,
                    icon: Constant.emailTextfieldIconName
                )
                .textContentType(.username)
                .keyboardType(.emailAddress)
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
                
                LoginTextField(
                    text: $password,
                    placeholder: Constant.passwordPlaceholder,
                    secureTextEntry: true,
                    icon: Constant.passwordTextfieldIconName
                )
                .textContentType(.password)
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
                
                Button {
                    Task {
                        await viewModel.login(email: email, password: password)
                    }
                } label: {
                    Text(Constant.loginButtonTitle)
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
                                
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack {
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                }
                .frame(width: 300, height: 44)
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthViewModel())
}
