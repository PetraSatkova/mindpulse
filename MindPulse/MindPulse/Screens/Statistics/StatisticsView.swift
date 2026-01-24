//
//  StatisticsView.swift
//  MindPulse
//
//  Created by Petra  Šátková on 24.01.2026.
//

import SwiftUI

struct StatisticsView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State private var isFilterPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Hiii")
            }
        }
        .themedBackground()
        .navigationTitle("Statistics")
        .toolbar{ // TODO not showing why?
            ToolbarItemGroup(placement: .topBarTrailing){
                // filter button
                Button(action: {
                    isFilterPresented.toggle()
                }) {
                    Label("Filter", systemImage: "line.3.horizontal.decrease")
                        .labelStyle(.iconOnly)
                }
            }
        }
    }
}

#Preview {
    StatisticsView()
}
