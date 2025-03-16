//
//  User.swift
//  BasicProject
//
//  Created by Linas Venclavičius on 14/03/2025.
//

import Foundation

struct User: Codable, Identifiable {
    let id: String
    let fullName: String
    let email: String
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        formatter.style = .abbreviated

        if let components = formatter.personNameComponents(from: fullName) {
            return formatter.string(from: components)
        } else {
            return ""
        }
    }
}

extension User {
    static var mockUser = User(id: UUID().uuidString, fullName: "My Name", email: "my.name@example.com")
}
