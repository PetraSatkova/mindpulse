//
//  NewActivityView.swift
//  MindPulse
//
//  Created by Adam Hamr on 28.12.2025.
//

import SwiftUI

struct NewActivityView: View {
    
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.dismiss) var dismiss
    
    @State private var emoji: String = "🧘"
    @State private var name: String = ""
    @State private var color: Color = .blue
    @State private var HRisActive: Bool = false
    
    var cardBackgroundColor: Color {
         themeManager.currentTheme.isDark ? Color(.systemGray6) : Color.white
     }
     
     var textColor: Color {
         themeManager.currentTheme.isDark ? .white : .black
     }
    
    var body: some View {
        
        VStack{
            
            HStack{
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
                
                Button(action: {
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
                VStack(spacing: 24) {
                    Button(action: {
                        
                    }){
                        VStack(spacing: 12) {
                            ZStack{
                                Circle()
                                    .stroke(Color.black, lineWidth: 2)
                                    .frame(width: 100, height: 100)
                                
                                Text(emoji)
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
                }
                
                TextField("Activity name", text: $name)
                    .padding()
                    .background(cardBackgroundColor)
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                
                VStack(alignment: .leading, spacing: 10){
                    Text("Customization")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    HStack{
                        Text("Card color")
                            .fontWeight(.medium)
                        
                        Spacer()
                        
                        Circle()
                            .fill(color)
                            .frame(width: 30, height: 30)
                        
                        Button("Select"){
                            
                        }
                        .foregroundColor(.blue)
                    }
                    .padding()
                    .background(cardBackgroundColor)
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                    
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
        
}
