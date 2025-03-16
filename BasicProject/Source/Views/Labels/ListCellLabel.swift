//
//  ListCellLabel.swift
//  BasicProject
//
//  Created by Linas Venclavičius on 14/03/2025.
//

import SwiftUI

struct ListCellLabel: LabelStyle {
    var spacing: Double = 12.0
    var labelColor: Color = .primary
    var iconColor: Color = .secondary
    
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: spacing) {
            configuration.icon
                .foregroundStyle(iconColor)
                .imageScale(.large)
            configuration.title
                .foregroundStyle(labelColor)
        }
    }
}
