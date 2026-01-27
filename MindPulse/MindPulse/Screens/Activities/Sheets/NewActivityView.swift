//
//  NewActivityView.swift
//  MindPulse
//
//  Created by Adam Hamr on 28.12.2025.
//

import SwiftUI
import ElegantEmojiPicker

@available(iOS 26.0, *)
struct NewActivityView: View {
    @State var viewModel: ActivitiesViewModel
    
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.dismiss) var dismiss
    
    var watchConnector: WatchConnecting = DIContainer.shared.resolve()
    
    @State private var emoji: Emoji? = nil
    @State private var name: String = ""
    @State private var color: PaletteColor = .blue
    @State private var HRisActive: Bool = false
    
    @State private var isEmojiPickerPresented: Bool = false
    
    var cardBackgroundColor: Color {
        themeManager.currentTheme.isDark ? Color(.systemGray6) : Color.white
    }
    
    var textColor: Color {
        themeManager.currentTheme.isDark ? .white : .black
    }
    
    
    var body: some View {
        
        VStack{
            // head
            HStack{
                // dismiss
                Button(action: {dismiss()}){
                    Image(systemName: "xmark")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(themeManager.currentTheme.isDark ? .white : .gray)
                        .padding(8)
                        .background(themeManager.currentTheme.isDark ? Color(.systemGray5) : Color(.systemGray5))
                        .clipShape(Circle())
                }
                
                Spacer()
                
                Text("New Activity")
                    .font(.headline)
                    .foregroundColor(textColor) // Barva nadpisu
                Spacer()
                
                // save
                Button(action: {
                    print("📝 Creating activity. Toggle HRisActive: \(HRisActive)")
                    let newActivity: ActivityModel = createActivity() // create new activity model
                    print("📝 Created model. hrRecording: \(newActivity.hrRecording)")
                    viewModel.addActivity(newActivity: newActivity)   // save to core data
                    watchConnector.sendActivity(activity: newActivity) // send to watch
                    viewModel.fetchActivities() 
                    dismiss()
                }) {
                    Image(systemName: "checkmark")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.blue)
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal)
            .padding(.top, 20)
            
            
            ScrollView{
                // emoji
                VStack(spacing: 24) {
                    Button(action: {
                        isEmojiPickerPresented.toggle()
                    }){
                        VStack(spacing: 12) {
                            ZStack{
                                Circle()
                                    .stroke(Color.black, lineWidth: 2)
                                    .frame(width: 100, height: 100)
                                
                                Text(emoji?.emoji ?? "")
                                    .font(.system(size: 50))
                            }
                            .padding(.top, 20)
                            
                            Text("Tap to select emoji")
                                .font(.subheadline)
                                .foregroundColor(textColor)
                                .padding(.bottom, 20)
                        }
                        .frame(maxWidth: .infinity)
                        .background(cardBackgroundColor)
                        .cornerRadius(20)
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                    }
                    .emojiPicker(
                        isPresented: $isEmojiPickerPresented,
                        selectedEmoji: $emoji,
                        configuration: ElegantConfiguration(showRandom: false, showReset: false)
                    )
                }
                
                // activity name
                TextField("Activity name", text: $name)
                    .padding()
                    .background(cardBackgroundColor)
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                
                
                //Color picker
                VStack(alignment: .leading, spacing: 10){
                    Text("Customization")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Card color")
                            .fontWeight(.medium)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(PaletteColor.allCases, id: \.self) { paletteColor in
                                    Button(action: {
                                        withAnimation(.spring()) {
                                            self.color = paletteColor
                                        }
                                    }) {
                                        ZStack {
                                            if self.color == paletteColor {
                                                Circle()
                                                    .stroke(textColor.opacity(0.5), lineWidth: 2)
                                                    .frame(width: 38, height: 38)
                                            }
                                            
                                            Circle()
                                                .fill(paletteColor.swiftUIColor)
                                                .frame(width: 30, height: 30)
                                        }
                                    }
                                }
                            }
                            .padding(.vertical, 5)
                            .padding(.horizontal, 2)
                        }
                    }
                    .padding()
                    .background(cardBackgroundColor)
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                    
                    // hr recording switch
                    HStack{
                        Text("HR recording")
                            .fontWeight(.medium)
                        
                        Spacer()
                        
                        Toggle("", isOn: $HRisActive)
                    }
                    .padding()
                    .background(cardBackgroundColor)
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                }
            }
            .padding()
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
        .background(themeManager.currentTheme.isDark ? Color.black.ignoresSafeArea() : Color.white.ignoresSafeArea())
    }
    
    private func createActivity() -> ActivityModel {
        let activity = ActivityModel(
            id: UUID(),
            name: name,
            emoji: emoji?.emoji ?? "👀",
            color: color,
            hrRecording: HRisActive
        )
        return activity
    }
}
