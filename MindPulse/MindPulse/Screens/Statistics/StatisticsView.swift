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
    
    var recordsToShow: [RecordModel] {
        if let a = filteredActivity {
            return viewModel.fetchRecordsByActivity(activity: a)
        }
        return viewModel.state.records
    }

    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack(alignment: .center, spacing: 70) {
                    StatsCard(
                        title: filteredActivity == nil ? "Total sessions" : filteredActivity?.name ?? "Activity" ,
                        value: filteredActivity == nil ? "\(viewModel.state.records.count)" : "16"
                    )
                    StatsCard(
                        title: filteredActivity == nil ? "Total time" : filteredActivity?.name ?? "Activity" ,
                        value: filteredActivity == nil ? "\(viewModel.state.records.count)" : "2h 15 min"
                    )
                }
                
                Spacer(minLength: 30)
                
                LineChart(points: viewModel.state.weeklyPoints ?? [])
                
                Spacer(minLength: 50)
                
                Text("Last sessions")
                    .padding()
                    .font(Font.title3.bold())
                
                List {
                    ForEach(recordsToShow) { record in
                        NavigationLink {
                            if let selected = selectedRecord {
                                StatisticsDetailView(selectedRecord: selected)
                            }
                        } label: {
                            SessionRow(
                                title: filteredActivity == nil ? viewModel.getActivityNameByRecord(record: record) : filteredActivity?.name ?? "unknown",
                                value: String(DurationFormatter.formatSeconds(seconds: Int(record.durationSeconds))),
                                date: record.date
                            )
                        }
                        
                    }
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchActivities()
            viewModel.fetchRecords()
            viewModel.calculateTotalTime(activity: nil)
            viewModel.calculateTotalCount(activity: nil)
            viewModel.minutesByDayForCurrentWeek(records: recordsToShow)
        }
        .onChange(of: filteredActivity) { _, newValue in
            viewModel.calculateTotalTime(activity: newValue)
            viewModel.calculateTotalCount(activity: newValue)
            viewModel.minutesByDayForCurrentWeek(records: recordsToShow)
        }
    }
}

#Preview {
//    StatisticsView()
//        .environmentObject(ThemeManager())
}
