//
//  UserProfileView.swift
//  BasicProject
//
//  Created by Linas Venclavičius on 13/03/2025.
//

import SwiftUI

struct UserProfileView: View {
    var body: some View {
        List {
            Section {
                HStack(spacing: 10) {
                    Text(User.mockUser.initials)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 60, height: 60)
                        .background(Color(.systemGray3))
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text(User.mockUser.fullName)
                            .font(.headline)
                        Text(User.mockUser.email)
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
                Label("Sign Out", systemImage: "arrow.left.circle.fill")
                    .labelStyle(ListCellLabel(iconColor: .red))
                
                Label("Delete Account", systemImage: "xmark.circle.fill")
                    .labelStyle(ListCellLabel(iconColor: .red))
            }
        }
    }
}

#Preview {
    UserProfileView()
}
