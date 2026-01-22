//
//  ActivitySetupView.swift
//  MindPulse
//
//  Created by Adam Hamr on 21.01.2026.
//

import SwiftUI

struct ActivitySetupView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State var selectedMins: Int = 10
    
    var activity: ActivityModel
    
    var body: some View {
        Group{
            VStack{
                ActivityIconView(themeManager: themeManager, activity: activity)
                ActivityTimePicker(selectedMins: $selectedMins, themeManager: themeManager, activity: activity)
                
                Button("Dive in"){
                    
                }
                .buttonStyle(.primary)
            }
        }
        .navigationTitle(activity.name)
        .themedBackground()
    }
}
