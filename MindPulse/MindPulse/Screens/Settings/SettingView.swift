//
//  SettingView.swift
//  MindPulse
//
//  Created by Adam Hamr on 25.11.2025.
//

import SwiftUI

struct SettingView: View {
    
    //@State private var isThemeSelectorPresented: Bool = false
    private let appVersion: String = Bundle.main.appVersion ?? "-"
    
    var body: some View {
        VStack{
            SettingCard(title: "Theme", subtitle: "Calm Dawn", buttonText: "Select")
            SettingCard(title: "Notifications", subtitle: "Off", buttonText: "Set")
            Spacer()
            SettingCard(title: "App version", subtitle: appVersion)
        }
        .navigationTitle("Settings")
    }
}

extension Bundle{
    var appVersion: String? {
        infoDictionary?["CFBundleShortVersionString"] as? String ?? "-"
    }
    
}
    
#Preview {
    SettingView()
}

