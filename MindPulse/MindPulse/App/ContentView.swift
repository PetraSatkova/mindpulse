//
//  ContentView.swift
//  MindPulse
//
//  Created by Adam Hamr on 25.11.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedTab = 0
    @State private var isSettingPresented: Bool = false
    
    var body: some View {
        NavigationStack{
            TabView(selection: $selectedTab) {
                Tab("Activities", systemImage: "house.circle.fill", value: 0) {
                    ActivitiesView()
                    
                }
                Tab("Statistics", systemImage: "list.bullet.circle", value: 1){
                    Text("Hiii").themedBackground()
                }
                Tab("Test", systemImage: "house", value: 3){
                    Test()
                }
            }
            .navigationTitle(selectedTab == 1 ? "Statistics" : "MindPulse")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing){
                    Button(action: {
                        isSettingPresented = true
                    }) {
                        Label("Add Place", systemImage: "gear")
                            .labelStyle(.iconOnly)
                    }
                }
            }
            .navigationDestination(isPresented: $isSettingPresented) {
                SettingView()
            }
            
        }
        
    }
}

#Preview {
    ContentView()
}
