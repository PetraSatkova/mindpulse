//
//  TimerView.swift
//  MindPulse Watch Watch App
//
//  Created by Petra  Šátková on 24.01.2026.
//

import SwiftUI

struct TimerView: View {
    @State var viewModel: WatchViewModel = WatchViewModel()
    var activity: ActivityModel
    
    @State var hours: Int = 0
    @State var minutes: Int = 0
    @State var seconds: Int = 0
    @State var isTimerRunning: Bool = false
    @State var paused: Bool = false
    @State var finished: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if (!isTimerRunning) {
                    TimeWheelPickerView(hours: $hours, minutes: $minutes, seconds: $seconds)
                    Button {
                        isTimerRunning.toggle()
                        viewModel.startActivity()
                    } label: {
                        Text("Dive in")
                    }
                    .buttonStyle(.primary)
                } else {
                    // odpocitavanie
                    Button {
                        paused.toggle()
                    } label: {
                        Text("| |")
                    }
                    .buttonStyle(.primary)
                }
                
                // if finished -> viewmodel.stopActivity(activity.id)
            }
        }
        .navigationTitle("Meditation")
    }
}

#Preview {
    TimerView(viewModel: WatchViewModel(), activity: .sampleData.first ?? ActivityModel(
        id: UUID(), name: "meditation", emoji: "", color: .green, hrRecording: true))
}
