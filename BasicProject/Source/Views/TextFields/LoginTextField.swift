//
//  LoginTextField.swift
//  BasicProject
//
//  Created by Linas Venclavičius on 16/03/2025.
//

import SwiftUI

struct LoginTextField: View {
    @FocusState private var isFocused: Bool
    
    @Binding var text: String
    let placeholder: String
    let secureTextEntry: Bool
    let icon: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            Label(placeholder, systemImage: icon)
                .foregroundColor(!text.isEmpty && isFocused ? .accentColor : Color(.placeholderText))
                .offset(y: text.isEmpty ? 0 : -20)
                .scaleEffect(text.isEmpty ? 1: 0.8, anchor: .leading)
            
            if secureTextEntry {
                SecureField(.emptyString, text: $text)
                    .offset(y: text.isEmpty ? 0 : 8)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .focused($isFocused)
            } else {
                TextField(.emptyString, text: $text)
                    .offset(y: text.isEmpty ? 0 : 8)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .focused($isFocused)
            }
        }
        .animation(.default, value: text)
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .stroke(Color.accentColor, lineWidth: isFocused ? 1 : 0)
                .shadow(radius: 5)
        )
    }
}
