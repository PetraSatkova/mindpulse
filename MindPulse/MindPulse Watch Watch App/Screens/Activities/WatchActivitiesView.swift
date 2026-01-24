//
//  WatchActivitiesView.swift
//  MindPulse
//
//  Created by Adam Hamr on 20.01.2026.
//

import SwiftUI

struct WatchActivitiesView: View {
    
    let activities = ActivityModel.sampleData
    @State var viewModel: WatchViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: -20) {
                    ForEach(Array(activities.enumerated()), id: \.element.id) { index, activity in
                        WatchActivityCard(activity: activity)
                            .containerRelativeFrame(.vertical, count: 1, spacing: 0)
                            .scrollTransition(.interactive, axis: .vertical) { content, phase in
                                content
                                    .scaleEffect(phase.value < 0 ? 1.0 : (phase.isIdentity ? 1.0 : 0.8), anchor: .bottom)
                                    .opacity(phase.value < 0 ? (1.0 + phase.value) : (phase.isIdentity ? 1.0 : 0.5))
                                    .blur(radius: phase.value < 0 ? 0 : (phase.isIdentity ? 0 : 2))
                                    .offset(y: phase.value < 0 ? phase.value * 130 : (phase.value > 0 ? -50 : 0))
                            }
                            .zIndex(Double(activities.count - index))
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .navigationTitle("MindPulse")
        }
    }
}

#Preview {
    WatchActivitiesView(viewModel: WatchViewModel())
}
