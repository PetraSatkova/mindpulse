//
//  StatisticsDetailView.swift
//  MindPulse
//
//  Created by Petra  Šátková on 25.01.2026.
//

import SwiftUI

struct StatisticsDetailView: View {
    var selectedRecord: RecordModel
    @State var viewModel: StatisticsViewModel
    @EnvironmentObject var themeManager: ThemeManager
    
    
    var body: some View {
        
        var stats = viewModel.calculateHeartRateStats(from: viewModel.state.hrSamples)
        
        VStack(alignment: .center) {
            Text(selectedRecord.date.formatted())
            
            HRChart(samples: viewModel.state.hrSamples)
            
            HStack {
                StatsCard(title: LocalizedStringKey("Min HR"), value: String(stats?.min ?? 0))
                StatsCard(title: LocalizedStringKey("Max HR"), value: String(stats?.max ?? 0))
                StatsCard(title: LocalizedStringKey("Avg HR"), value: String(stats?.average ?? 0))
            }
            Spacer()
        }
        .navigationTitle(LocalizedStringKey(viewModel.getActivityNameByRecord(record: selectedRecord)))
        .themedBackground()
        .onAppear {
            viewModel.fetchHrSamplesByRecord(record: selectedRecord)
        }
    }
}

#Preview {
//    StatisticsDetailView()
}
