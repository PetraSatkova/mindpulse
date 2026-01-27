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
                StatsCard(title: LocalizedStringKey("Min HR"), value: "\(viewModel.state.minHR)")
                StatsCard(title: LocalizedStringKey("Max HR"), value: "\(viewModel.state.maxHR)")
                StatsCard(title: LocalizedStringKey("Avg HR"), value: "\(viewModel.state.avgHR)")
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
