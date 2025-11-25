//
//  ContentView.swift
//  MindPulse
//
//  Created by Adam Hamr on 25.11.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedTab = 0
    
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Activities", systemImage: "house.circle.fill", value: 0) {
                ActivitiesView()
                
            }
            Tab("Statistics", systemImage: "list.bullet.circle", value: 1){
                
            }
        }
        
    }
}

#Preview {
    ContentView()
}
