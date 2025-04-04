//
//  BasicProjectApp.swift
//  BasicProject
//
//  Created by Linas Venclavičius on 05/03/2025.
//

import SwiftUI
import FirebaseCore
import CoreData

@main
struct BasicProjectApp: App {
    @State private var viewModel: AuthViewModel

    init() {
        FirebaseApp.configure()
        DI.registerDependencies()
        _viewModel = State(initialValue: AuthViewModel())
    }

    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(viewModel)
                .environment(\.managedObjectContext, CoreDataStack.shared.context)
        }
    }
}
