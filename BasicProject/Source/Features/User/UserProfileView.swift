//
//  UserProfileView.swift
//  BasicProject
//
//  Created by Linas Venclavičius on 13/03/2025.
//

import SwiftUI

struct UserProfileView: View {
    @Environment(AuthViewModel.self) var viewModel
    
    var body: some View {
        if let user = viewModel.currentUser {
            List {
                Section {
                    HStack(spacing: 10) {
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 60, height: 60)
                            .background(Color(.systemGray3))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading) {
                            Text(user.fullName)
                                .font(.headline)
                            Text(user.email)
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                        }
                    }
                }
                
                Section("General") {
                    Label("Application version", systemImage: "gear.circle")
                        .labelStyle(ListCellLabel())
                        .badge(Text("1.0.0"))
                    
                }
                
                Section("Account") {
                    Button {
                        Task {
                            await viewModel.signOut()
                        }
                    } label: {
                        Label("Sign Out", systemImage: "arrow.left.circle.fill")
                            .labelStyle(ListCellLabel(iconColor: .red))
                    }
                    
                    Button {
                        Task {
                            await viewModel.deleteAccount()
                        }
                    } label: {
                        Label("Delete Account", systemImage: "xmark.circle.fill")
                            .labelStyle(ListCellLabel(iconColor: .red))
                    }
                }
            }
        }
    }
}

#Preview {
    UserProfileView()
}
