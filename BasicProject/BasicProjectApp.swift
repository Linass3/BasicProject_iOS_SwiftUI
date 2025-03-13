//
//  BasicProjectApp.swift
//  BasicProject
//
//  Created by Linas Venclavičius on 05/03/2025.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct BasicProjectApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.systemGray5
        UINavigationBar.appearance().backgroundColor = UIColor.systemYellow
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
