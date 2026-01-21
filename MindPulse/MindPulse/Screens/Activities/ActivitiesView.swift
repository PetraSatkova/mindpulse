//
//  ActivitiesView.swift
//  MindPulse
//
//  Created by Adam Hamr on 25.11.2025.
//

import SwiftUI

struct ActivitiesView: View{
    
    //@EnvironmentObject var themeManager: ThemeManager
    //@StateObject var themeManager = ThemeManager()
    
    var body: some View{
        NavigationStack{
            VStack{
                NavigationLink(destination: ActivitySetupView()){
                    ActivityCard(emoji: "🧘‍♀️", title: "Try", cardColor: PaletteColor.orange.swiftUIColor)
                }
            }
            .navigationTitle("MindPulse")
        }
        .themedBackground()
    }
}

