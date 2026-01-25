//
//  StatisticsView.swift
//  MindPulse
//
//  Created by Petra  Šátková on 24.01.2026.
//

import SwiftUI

struct StatisticsView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State var isFilterPresented: Bool = false
    @State var selectedActivity: ActivityModel? = nil
    @State var viewModel: StatisticsViewModel = StatisticsViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    StatsCard(
                        title: selectedActivity == nil ? "Total sessions" : selectedActivity?.name ?? "Activity" ,
                        value: selectedActivity == nil ? "\(viewModel.state.records.count)" : "16"
                    )
                    Spacer()
                    StatsCard(
                        title: selectedActivity == nil ? "Total time" : selectedActivity?.name ?? "Activity" ,
                        value: selectedActivity == nil ? "\(viewModel.state.records.count)" : "2h 15 min"
                    )
                }
                Spacer()
                Text("graph")
                Spacer()
                Text("Last sessions")
                ForEach(viewModel.state.records) { record in
                    NavigationLink {
                        StatisticsDetailView()
                    } label: {
                        SessionRow(
                            title: "",
                            value: "",
                            date: Date()
                        )
                    }

                }
            }
            
            .themedBackground()
        }
        .padding()
        .navigationTitle("Statistics")
        .onAppear {
            viewModel.fetchActivities()
            viewModel.fetchRcords()
            viewModel.calculateTime(activity: nil)
        }
        .toolbar { // TODO not showing why?
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
        .environmentObject(ThemeManager())
}
