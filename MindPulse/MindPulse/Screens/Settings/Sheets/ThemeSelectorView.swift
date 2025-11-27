//
//  ThemeSelectorView.swift
//  MindPulse
//
//  Created by Adam Hamr on 26.11.2025.
//

import SwiftUI

struct ThemeSelectorView: View {

    @Binding var activeSheet: ActiveSheet?
    @EnvironmentObject var themeManager: ThemeManager

    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: 16, alignment: .top),
        count: 3
    )

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    Text("Light")
                        .font(.title3)
                        .fontWeight(.bold)

                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(themeManager.availableThemes.filter { !$0.isDark }) { theme in
                            VStack(spacing: 8) {
                                RoundedRectangle(cornerRadius: 24, style: .continuous)
                                    .fill(theme.gradient)
                                    .frame(width: 100, height: 146)
                                    .shadow(color: .black.opacity(0.25), radius: 8, y: 6)

                                Text(theme.name)
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.center)
                            }
                            .onTapGesture {
                                themeManager.select(theme)
                            }
                        }
                    }

                    Text("Dark")
                        .font(.title3)
                        .fontWeight(.bold)

                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(themeManager.availableThemes.filter { $0.isDark }) { theme in
                            VStack(spacing: 8) {
                                RoundedRectangle(cornerRadius: 24, style: .continuous)
                                    .fill(theme.gradient)
                                    .frame(width: 100, height: 146)
                                    .shadow(color: .black.opacity(0.25), radius: 8, y: 6)

                                Text(theme.name)
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.center)
                            }
                            .onTapGesture {
                                themeManager.select(theme)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Theme")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Close") {
                        activeSheet = nil
                    }
                }
            }
        }
    }
}
