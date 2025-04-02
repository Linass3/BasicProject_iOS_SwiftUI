//
//  LoginView.swift
//  BasicProject
//
//  Created by Linas Venclavičius on 05/03/2025.
//

import SwiftUI

struct LoginView: View {
    private enum Constant {
        static let emailPlaceholder = "Email address"
        static let emailTextfieldIconName = "at"
        
        static let passwordPlaceholder = "Password"
        static let passwordTextfieldIconName = "key.fill"
    }

    @Environment(AuthViewModel.self) private var viewModel
    
    @Binding var email: String
    @Binding var password: String
    
    var body: some View {
        NavigationStack {
            VStack {
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
            }
        }
    }
}

#Preview {
    LoginView(email: Binding(get: { "" }, set: { _ in }), password: Binding(get: { "" }, set: { _ in }))
        .environment(AuthViewModel())
}
