//
//  StatsCard.swift
//  MindPulse
//
//  Created by Petra  Šátková on 25.01.2026.
//

import SwiftUI
import Charts

struct StatsCard: View {
    var title: LocalizedStringKey
    var value: String
    
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption)
            Text(value)
                .font(.callout)
        }
        .frame(height: 80)
        .preferredColorScheme(themeManager.currentTheme.isDark ? .dark : .light)
        .cornerRadius(25)
    }
}

#Preview {
    StatsCard(title: "Total Sessions", value: "16")
        .environmentObject(ThemeManager())
}
