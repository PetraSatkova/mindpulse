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
            List {
                ForEach(viewModel.state.activities) { activity in
                    NavigationLink(destination: ActivitySetupView()) {
                        ActivityCard(
                            emoji: activity.emoji,
                            title: activity.name,
                            cardColor: activity.color.swiftUIColor
                        )
                        .swipeActions {
                            Button(role: .destructive) {
                                viewModel.deleteActivity(activityId: activity.id)
                            } label: {
                                Image(systemName: "trash.fill")
                                    .background()
                            }
                            
                        }
                    }
                }
            }
        }
        .themedBackground()
        .onAppear {
            viewModel.fetchActivities()
        }
    }
}

