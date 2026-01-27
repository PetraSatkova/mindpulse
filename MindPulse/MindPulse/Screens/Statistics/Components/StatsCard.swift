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
        .padding(.horizontal, 20)
        .background(Color.white)
        .cornerRadius(25)
//        .shadow(radius: 10)
    }
}

#Preview {
    StatsCard(title: "Total Sessions", value: "16")
        .environmentObject(ThemeManager())
}
