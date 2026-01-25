//
//  SessionRow.swift
//  MindPulse
//
//  Created by Petra  Šátková on 25.01.2026.
//

import SwiftUI

struct SessionRow: View {
    var title: String
    var value: String
    var date: Date
    
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title3)
                    .bold()
                Text(value)
                    .font(.callout)
            }
            Spacer()
            Text(date, style: .date)
        }
        .frame(height: 80)
        .preferredColorScheme(themeManager.currentTheme.isDark ? .dark : .light)
        .cornerRadius(25)
        .padding()
    }
}

#Preview {
    SessionRow(title: "Meditation", value: "1h 20min", date: Date())
        .environmentObject(ThemeManager())
}
