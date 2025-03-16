//
//  RegistrationView.swift
//  BasicProject
//
//  Created by Linas Venclavičius on 16/03/2025.
//

import SwiftUI

struct RegistrationView: View {
    private enum Constant {
        static let mainLabelTitle = "MyApp"
        static let mainLabelIconName = "bolt.fill"
        
        static let namePlaceholder = "Full name"
        static let nameTextfieldIconName = "person.fill"
        
        static let emailPlaceholder = "Email address"
        static let emailTextfieldIconName = "at"
        
        static let passwordPlaceholder = "Password"
        static let confirmPasswordPlaceholder = "Confirm password"
        static let passwordTextfieldIconName = "key.fill"
        
        static let registerButtonTitle = "Register"
        
        static let alertButtonApproveText = "OK"
    }
    
    @EnvironmentObject private var viewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var fullName: String = .emptyString
    @State private var email: String = .emptyString
    @State private var password: String = .emptyString
    @State private var confirmPassword: String = .emptyString
    
    var body: some View {
        NavigationStack {
            VStack {
                Label(Constant.mainLabelTitle, systemImage: Constant.mainLabelIconName)
                    .foregroundStyle(
                        .linearGradient(Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing)
                    )
                    .font(.system(size: 40, weight: .medium, design: .rounded))
                
                LoginTextField(
                    text: $fullName,
                    placeholder: Constant.namePlaceholder,
                    secureTextEntry: false,
                    icon: Constant.nameTextfieldIconName
                )
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
                
                LoginTextField(
                    text: $email,
                    placeholder: Constant.emailPlaceholder,
                    secureTextEntry: false,
                    icon: Constant.emailTextfieldIconName
                )
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
                
                LoginTextField(
                    text: $password,
                    placeholder: Constant.passwordPlaceholder,
                    secureTextEntry: true,
                    icon: Constant.passwordTextfieldIconName
                )
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
                
                LoginTextField(
                    text: $confirmPassword,
                    placeholder: Constant.confirmPasswordPlaceholder,
                    secureTextEntry: true,
                    icon: Constant.passwordTextfieldIconName
                )
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
                
                Button {
                    Task {
                        await viewModel.signUp()
                    }
                } label: {
                    Text(Constant.registerButtonTitle)
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
                    dismiss()
                } label: {
                    HStack {
                        Text("Already have an account?")
                        Text("Login")
                            .fontWeight(.bold)
                    }
                }
                .frame(width: 300, height: 44)
            }
        }
    }
}

#Preview {
    RegistrationView()
        .environmentObject(AuthViewModel())
}
