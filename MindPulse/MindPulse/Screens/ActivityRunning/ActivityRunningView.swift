//
//  ActivityRunningView.swift
//  MindPulse
//
//  Created by Adam Hamr on 22.01.2026.
//

import SwiftUI

struct ActivityRunningView: View {
    
    var activity: ActivityModel
    var totalTime: Int = 15*60
    
    @State private var timeRemaining: Int
    @State private var isTimerRunning: Bool = true
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(activity: ActivityModel, totalTime: Int = 15 * 60) {
        self.activity = activity
        self.totalTime = totalTime
        _timeRemaining = State(initialValue: totalTime)
    }
    
    //Screen showing the progress of current session
    var body: some View {
        VStack {
            
            //activity name
            VStack(spacing: 40) {
                Text(activity.name)
                    .font(.system(size: 32, weight: .bold))
                    .padding(.top, 40)
                
                //Circular animation
                ZStack{
                    Circle().stroke(.gray.opacity(0.3), lineWidth: 20)
                    
                    Circle()
                        .trim(from: 0, to: CGFloat(timeRemaining) / CGFloat(totalTime))
                        .stroke(
                            LinearGradient(
                                colors: [Color.blue, Color.cyan],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            style: StrokeStyle(lineWidth: 20, lineCap: .round)
                        )
                        .rotationEffect(.degrees(-90)) // Start nahoře
                        .animation(.linear(duration: 1), value: timeRemaining)
                }
                
                //Remaining time
                VStack(spacing: 15) {
                    Text(formatTime(timeRemaining))
                        .font(.system(size: 64, weight: .bold, design: .rounded))
                
                    Text(activity.emoji)
                        .font(.system(size: 50))
                }
            }
            .padding(.horizontal, 50)
            
            Spacer()
            
            //Play/pause button
            Button(action:{
                isTimerRunning.toggle()
            }){
                Image(systemName: isTimerRunning ? "pause.fill" : "play.fill")
            }
            .buttonStyle(.primary)
            .padding(.horizontal, 40)
            .padding(.bottom, 50)
        }
        .onReceive(timer) { _ in
            if isTimerRunning && timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
    }
    
    
    func formatTime(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
