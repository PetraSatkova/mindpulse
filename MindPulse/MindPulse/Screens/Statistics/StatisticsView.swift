//
//  StatisticsView.swift
//  MindPulse
//
//  Created by Petra  Šátková on 24.01.2026.
//

import SwiftUI

struct StatisticsView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @Binding var filteredActivity: ActivityModel?
    @State var selectedRecord: RecordModel? = nil
    @State var viewModel: StatisticsViewModel = StatisticsViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 100) {
                StatsCard(
                    title: filteredActivity == nil ? "Total sessions" : LocalizedStringKey(filteredActivity?.name ?? "Activity"),
                    value: filteredActivity == nil ? "\(viewModel.state.records.count)" : "16" // TODO: Real value
                )
                StatsCard(
                    title: filteredActivity == nil ? "Total time" : LocalizedStringKey(filteredActivity?.name ?? "Activity"),
                    value: filteredActivity == nil ? "\(viewModel.state.records.count)" : "2h 15 min" // TODO: Real value
                )
            }
            .padding()
            
            Spacer(minLength: 30)
            
            LineChart()
            
            Spacer(minLength: 50)
            
            Text("Last sessions")
            List {
                ForEach(viewModel.state.records) { record in
                    NavigationLink {
                        if let selected = selectedRecord {
                            StatisticsDetailView(selectedRecord: selected)
                        }
                    } label: {
                        SessionRow(
                            title: "",
                            value: "",
                            date: Date()
                        )
                    }
                    
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchActivities()
            viewModel.fetchRcords()
            viewModel.calculateTime(activity: nil)
        }
        .onChange(of: filteredActivity) { _, newValue in
            viewModel.calculateTime(activity: newValue)
        }
    }
}

