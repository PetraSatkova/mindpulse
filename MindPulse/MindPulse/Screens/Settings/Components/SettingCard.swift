//
//  SettingCard.swift
//  MindPulse
//
//  Created by Adam Hamr on 25.11.2025.
//

import SwiftUI

struct SettingCard: View {
    var title: String
    var subtitle: String
    var buttonText: String?
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(title).font(.system(size: 22))
                Text(subtitle).font(.system(size: 16)).fontWeight(.semibold)
            }
            .padding(.leading,16).fontWeight(.bold)

            Spacer()
            
            if let buttonText = buttonText{
                Button(buttonText) {
                    
                }
                .padding(.trailing,16)
            }
        }
        .frame(maxWidth: 350, alignment: .leading)
        .frame(height: 100)
        .background(Color.calmDawnEnd)
        .cornerRadius(25)
    }
}
