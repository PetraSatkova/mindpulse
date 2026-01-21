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
    
    var body: some View {
        Group{
            VStack{
         
                ActivityIconView(themeManager: themeManager)
                ActivityTimePicker(selectedMins: $selectedMins, themeManager: themeManager)
    
                
                Button("Dive in"){
                    
                }
                .buttonStyle(.primary)
            }
        }
        .navigationTitle("Meditation")
        .themedBackground()
    }
}
