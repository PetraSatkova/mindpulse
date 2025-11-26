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
                Text("Hello World")
            }
            .navigationTitle("MindPulse")
        }
        .themedBackground()
    }
}

