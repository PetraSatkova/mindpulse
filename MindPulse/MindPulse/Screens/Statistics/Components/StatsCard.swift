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
        VStack(alignment: .trailing) {
            Text(title)
                .font(.title3)
            Text(value)
                .font(.callout)
                .bold()
        
        }
        .frame(height: 80)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .background(themeManager.currentTheme.isDark ? Color.black : Color.white)
        .preferredColorScheme(themeManager.currentTheme.isDark ? .dark : .light)
        .cornerRadius(25)
    }
}

#Preview {
    StatsCard(title: "Total Sessions", value: "16")
        .environmentObject(ThemeManager())
}
