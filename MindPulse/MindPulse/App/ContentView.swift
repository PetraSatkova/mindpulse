//
//  ContentView.swift
//  MindPulse
//
//  Created by Adam Hamr on 25.11.2025.
//

import SwiftUI

@available(iOS 26.0, *)
struct ContentView: View {
    // init for viewModel that is passed around
    var viewModel: ActivitiesViewModel = ActivitiesViewModel()
    
    @State var selectedTab = 0
    @State private var isSettingPresented: Bool = false
    @State private var isNewActivityPresented: Bool = false
    
    var body: some View {
        NavigationStack{
            ZStack(alignment: .bottomTrailing) {
                TabView(selection: $selectedTab) {
                    Tab("Activities", systemImage: "house.circle.fill", value: 0) {
                        ActivitiesView(viewModel: viewModel)
                        
                    }
                    Tab("Statistics", systemImage: "list.bullet.circle", value: 1){
                        Text("Hiii").themedBackground()
                    }
                    Tab("Test", systemImage: "house", value: 3){
                        Test()
                    }
                }
                // plus button
                NewActivityButton {
                    isNewActivityPresented = true
                }
                .sheet(isPresented: $isNewActivityPresented){
                    NewActivityView(viewModel: viewModel).presentationDetents([.fraction(0.75), .large])
                }
                .padding(.trailing, 20)
                .padding(.bottom, 60)
            }
            .navigationTitle(selectedTab == 1 ? "Statistics" : "MindPulse")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing){
                    // settings button
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
    if #available(iOS 26.0, *) {
        ContentView()
    } else {
        // Fallback on earlier versions
    }
}
