//
//  ExpensesView.swift
//  BasicProject
//
//  Created by Linas Venclavičius on 03/04/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = AddExpensesViewModel()
    @State private var selectedTab: Tab = .home
    
    var body: some View {
//        TabView {
//            AddExpensesView()
//                .tabItem {
//                    Image(systemName: "plus")
//                    Text("Add")
//                }
//            
//            AddExpensesView()
//                .tabItem {
//                    Image(systemName: "house")
//                    Text("Home")
//                }
//            
//            UserProfileView()
//                .tabItem {
//                    Image(systemName: "person.circle")
//                    Text("Profile")
//                }
//        }
        ZStack {
            VStack {
                switch selectedTab {
                case .home:
                    ExpensesStatusView()
                case .add:
                    AddExpensesView()
                case .profile:
                    UserProfileView()
                }
            }
            
            VStack {
                Spacer()
                
                TabBarView(selectedTab: $selectedTab)
            }
        }
        .environment(viewModel)
    }
}

#Preview {
    ContentView()
}
