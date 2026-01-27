//
//  WatchActivityRunningView.swift
//  MindPulse Watch Watch App
//
//  Created by Adam Hamr on 27.01.2026.
//

import SwiftUI
import Combine

struct WatchActivityRunningView: View {
    
    var activity: ActivityModel
    var totalTime: Int
    @State var viewModel = WatchViewModel()
    
    @State private var timeRemaining: Int
    @State private var isTimerRunning: Bool = true
    @State private var endTime: Date?
    @Environment(\.scenePhase) var scenePhase
    
    // Timer publisher
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(activity: ActivityModel, totalTime: Int) {
        self.activity = activity
        self.totalTime = totalTime
        _timeRemaining = State(initialValue: totalTime)
    }
    
    var body: some View {
        VStack {
            ZStack {
                // Background circle
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 8)
                
                // Animated foreground circle
                Circle()
                    .trim(from: 0, to: CGFloat(timeRemaining) / CGFloat(totalTime))
                    .stroke(
                        activity.color.swiftUIColor,
                        style: StrokeStyle(lineWidth: 8, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.linear(duration: 1), value: timeRemaining)
                
                // Time display
                VStack(spacing: 0) {
                    Text(formatTime(timeRemaining))
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .contentTransition(.numericText())
                    
                    if !isTimerRunning {
                        Text("PAUSED")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.yellow)
                            .padding(.top, 2)
                    }
                }
            }
            .padding(.horizontal, 4)
            
            Spacer()
            
            // Controls
            Button(action: {
                withAnimation {
                    isTimerRunning.toggle()
                }
                if isTimerRunning {
                    // Resuming: recalculate endTime based on current timeRemaining
                    endTime = Date().addingTimeInterval(Double(timeRemaining))
                    viewModel.startActivity()
                } else {
                    // Pausing: endTime becomes irrelevant, we hold on to current timeRemaining
                    endTime = nil
                    viewModel.stopActivity(activityId: activity.id)
                }
            }) {
                Image(systemName: isTimerRunning ? "pause.fill" : "play.fill")
                    .font(.title2)
            }
            .buttonStyle(.borderedProminent)
            .tint(isTimerRunning ? .orange : .green)
            .frame(height: 44) // Explicit height for button area if needed
            .padding(.bottom, 2)
        }
        .padding(4)
        .navigationTitle(activity.name)
        .navigationBarTitleDisplayMode(.inline)
        .onReceive(timer) { _ in
            guard isTimerRunning, let endTime = endTime else { return }
            
            let remaining = Int(endTime.timeIntervalSince(Date()))
            if remaining >= 0 {
                timeRemaining = remaining
            } else {
                timeRemaining = 0
                isTimerRunning = false
                self.endTime = nil
                viewModel.stopActivity(activityId: activity.id)
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                // When app becomes active, the timer loop continues.
                // If we have an endTime, the next tick helps, but to be instant:
                if isTimerRunning, let endTime = endTime {
                    let remaining = Int(endTime.timeIntervalSince(Date()))
                    timeRemaining = max(0, remaining)
                }
            }
        }
        .onAppear {
            if isTimerRunning && endTime == nil {
                endTime = Date().addingTimeInterval(Double(timeRemaining))
            }
            viewModel.startActivity()
        }
        .onDisappear {
            if isTimerRunning {
                viewModel.stopActivity(activityId: activity.id)
            }
        }
    }
    
    func formatTime(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    WatchActivityRunningView(activity: .sampleData[0], totalTime: 60)
}
