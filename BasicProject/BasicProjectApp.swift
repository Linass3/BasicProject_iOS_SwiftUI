//
//  BasicProjectApp.swift
//  BasicProject
//
//  Created by Linas Venclavičius on 05/03/2025.
//

import SwiftUI
import FirebaseCore

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
            ContentView()
                .environment(viewModel)
                .environment(\.managedObjectContext, DI.resolve(CoreDataStack.self).context)
        }
    }
}
