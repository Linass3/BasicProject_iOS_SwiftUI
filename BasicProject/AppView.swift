//
//  ContentView.swift
//  BasicProject
//
//  Created by Linas Venclavičius on 16/03/2025.
//

import SwiftUI

struct AppView: View {
    @Environment(AuthViewModel.self) private var viewModel
    
    var body: some View {
        NavigationStack {
            @Bindable var viewModel = viewModel
            AuthView()
                .navigationDestination(isPresented: $viewModel.isLoggedIn) {
                    ContentView()
                        .navigationBarBackButtonHidden(true)
                }
                .overlay {
                    if viewModel.isLoading {
                        ZStack {
                            Color.white.opacity(0.5)
                                .edgesIgnoringSafeArea(.all)
                            
                            ProgressView()
                                .controlSize(.large)
                                .tint(.gray)
                        }
                    }
                }
        }
    }
}
