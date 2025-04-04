//
//  TabBarView.swift
//  BasicProject
//
//  Created by Linas Venclavičius on 03/04/2025.
//

import SwiftUI

enum Tab: CaseIterable {
    case add
    case home
    case profile
    
    var unselectedImage: String {
        switch self {
        case .add:
            return "plus"
        case .home:
            return "house"
        case .profile:
            return "person"
        }
    }
    
    var selectedImage: String {
        switch self {
        case .add:
            return "plus"
        case .home:
            return "house.fill"
        case .profile:
            return "person.fill"
        }
    }
}

struct TabBarView: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.hashValue) { tab in
                    Spacer()
                    Image(systemName: selectedTab == tab ? tab.selectedImage : tab.unselectedImage)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .contentShape(Rectangle())
                        .foregroundColor(selectedTab == tab ? .white : .white.opacity(0.5))
                        .scaleEffect(selectedTab == tab ? 1.3 : 1)
                        .font(.system(size: 24))
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
            .frame(width: nil, height: 60)
            .background(.green)
            .clipShape(RoundedRectangle(cornerRadius: 50))
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    TabBarView(selectedTab: .constant(.home))
}
