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
    @State var viewModel: StatisticsViewModel = StatisticsViewModel()
    
    var recordsToShow: [RecordModel] {
        if let a = filteredActivity {
            return viewModel.fetchRecordsByActivity(activity: a)
        }
        return viewModel.state.records
    }

    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                StatsCard(
                    title: filteredActivity == nil ? "Total sessions" : LocalizedStringKey(filteredActivity?.name ?? "Activity") ,
                    value: String(viewModel.state.totalCount)
                )
                Spacer()
                StatsCard(
                    title: filteredActivity == nil ? "Total time" : LocalizedStringKey(filteredActivity?.name ?? "Activity") ,
                    value: String(viewModel.state.totalMinutes)
                )
            }
            
            Spacer(minLength: 30)
            
            LineChart(points: viewModel.state.weeklyPoints ?? [])
            
            Spacer(minLength: 50)
            
            Text("Last sessions")
                .font(Font.title3.bold())
            
            List {
                ForEach(recordsToShow) { record in
                    NavigationLink {
                        StatisticsDetailView(selectedRecord: record, viewModel: viewModel)
                    } label: {
                        SessionRow(
                            title: filteredActivity == nil ? viewModel.getActivityNameByRecord(record: record) : filteredActivity?.name ?? "unknown",
                            value: String(DurationFormatter.formatSeconds(seconds: Int(record.durationSeconds))),
                            date: record.date
                        )
                    }
                    
                }
            }
            .scrollContentBackground(.hidden)
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
