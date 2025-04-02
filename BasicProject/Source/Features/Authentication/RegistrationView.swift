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
    }
    
    @Environment(AuthViewModel.self) private var viewModel

    @Binding var fullName: String
    @Binding var email: String
    @Binding var password: String
    @Binding var confirmPassword: String
    
    var body: some View {
        NavigationStack {
            VStack {
                LoginTextField(
                    text: $fullName,
                    placeholder: Constant.namePlaceholder,
                    secureTextEntry: false,
                    icon: Constant.nameTextfieldIconName
                )
                .textContentType(.name)
                .textInputAutocapitalization(.words)
                .keyboardType(.emailAddress)
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
                
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
                .textContentType(.newPassword)
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
                
                LoginTextField(
                    text: $confirmPassword,
                    placeholder: Constant.confirmPasswordPlaceholder,
                    secureTextEntry: true,
                    icon: Constant.passwordTextfieldIconName
                )
                .textContentType(.newPassword)
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    RegistrationView(
        fullName: Binding(get: { "" }, set: { _ in }),
        email: Binding(get: { "" }, set: { _ in }),
        password: Binding(get: { "" }, set: { _ in }),
        confirmPassword: Binding(get: { "" }, set: { _ in })
    )
        .environment(AuthViewModel())
}
