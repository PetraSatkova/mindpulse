//
//  ActivitiesView.swift
//  MindPulse
//
//  Created by Adam Hamr on 25.11.2025.
//

import SwiftUI

struct ActivitiesView: View{
    
    @State var viewModel: ActivitiesViewModel
    
    init(viewModel: ActivitiesViewModel) {
        self.viewModel = viewModel
    }
    
    //@EnvironmentObject var themeManager: ThemeManager
    //@StateObject var themeManager = ThemeManager()
    
    var body: some View{
        NavigationStack{
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.state.activities) { activity in
                        NavigationLink(destination: ActivitySetupView(activity: activity)) {
                            ActivityCard(
                                emoji: activity.emoji,
                                title: activity.name,
                                cardColor: activity.color.swiftUIColor
                            )
                        }
                        .buttonStyle(.plain)
                        .contextMenu {
                            Button(role: .destructive) {
                                viewModel.deleteActivity(activityId: activity.id)
                            } label: {
                                Label("Smazat", systemImage: "trash")
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .themedBackground()
        .onAppear {
            viewModel.fetchActivities()
        }
    }
}

