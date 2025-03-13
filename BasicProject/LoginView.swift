//
//  LoginView.swift
//  BasicProject
//
//  Created by Linas Venclavičius on 05/03/2025.
//

import SwiftUI

struct LoginView: View {

    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Label("Login", systemImage: "bolt.fill")
                    .foregroundStyle(
                        .linearGradient(Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing)
                    )
                    .font(.system(size: 40, weight: .medium, design: .rounded))
                    
                LoginTextField(text: $viewModel.username, placeholder: "Username", secureTextEntry: false)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 20)

                LoginTextField(text: $viewModel.password, placeholder: "Password", secureTextEntry: true)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 20)

                Button {
//                    await viewModel.login()
                } label: {
                    Text("Login")
                        .frame(width: 300, height: 44)
                        .font(.title2)
                }
                .alert(viewModel.errorMessage, isPresented: $viewModel.showLoginAlert) {
                    Button("OK", role: .cancel) {
                        viewModel.showLoginAlert = false
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

struct LoginTextField: View {
    @FocusState private var isFocused: Bool
    
    @Binding var text: String
    let placeholder: String
    let secureTextEntry: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            Label(placeholder, systemImage: secureTextEntry ? "key.fill" : "person.fill")
                .foregroundColor(!text.isEmpty && isFocused ? .accentColor : Color(.placeholderText))
                .offset(y: text.isEmpty ? 0 : -20)
                .scaleEffect(text.isEmpty ? 1: 0.8, anchor: .leading)
            
            if secureTextEntry {
                SecureField("", text: $text)
                    .offset(y: text.isEmpty ? 0 : 8)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .focused($isFocused)
            } else {
                TextField("", text: $text)
                    .offset(y: text.isEmpty ? 0 : 8)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .focused($isFocused)
            }
        }
        .animation(.default, value: text)
        .padding(20)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(isFocused ? Color.accentColor : Color.gray, lineWidth: 1)
        )
    }
}

#Preview {
    LoginView()

}
