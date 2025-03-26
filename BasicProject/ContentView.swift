//
//  ContentView.swift
//  BasicProject
//
//  Created by Linas Venclavičius on 16/03/2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if viewModel.userSession != nil && viewModel.currentUser != nil {
                UserProfileView()
                    .transition(.move(edge: .leading))
            } else {
                LoginView()
                    .transition(.move(edge: .leading))
            }
        }
        .overlay {
            if viewModel.isLoading {
                ZStack {
                    Color.white.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                    
                    ProgressView()
                        .controlSize(.large)
                        .tint(.black)
                }
            }
        }
    }
}
