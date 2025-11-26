//
//  SettingView.swift
//  MindPulse
//
//  Created by Adam Hamr on 25.11.2025.
//

import SwiftUI

enum ActiveSheet: Identifiable{
    case themeSelector
    case notificationSettings
    
    var id: Int{
        hashValue
    }
}

struct SettingView: View {
    
    @State private var activeSheet: ActiveSheet?
    
    @EnvironmentObject var themeManager: ThemeManager

    private let appVersion: String = Bundle.main.appVersion ?? "-"
    
    var body: some View {
        VStack{
            SettingCard(title: "Theme", subtitle: themeManager.currentTheme.name, buttonText: "Select"){
                activeSheet = .themeSelector
            }
            SettingCard(title: "Notifications", subtitle: "Off", buttonText: "Set"){
                activeSheet = .notificationSettings
            }
            
            Spacer()
            
            SettingCard(title: "App version", subtitle: appVersion)
        }
        .navigationTitle("Settings")
        .sheet(item: $activeSheet) { sheet in
            switch sheet {
            case .themeSelector:
                ThemeSelectorView(activeSheet: $activeSheet)
            case .notificationSettings:
                Text("Notification settings")
            }
            
        }
        
    }
}

extension Bundle{
    var appVersion: String? {
        infoDictionary?["CFBundleShortVersionString"] as? String ?? "-"
    }
    
}
    
#Preview {
    SettingView()
        .environmentObject(ThemeManager())
}

