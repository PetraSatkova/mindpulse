//
//  ActivityModel.swift
//  MindPulse
//
//  Created by Petra  Šátková on 20.01.2026.
//

import SwiftUI
import ElegantEmojiPicker

struct ActivityModel: Identifiable {
    public var id: UUID
    public var name: String
    public var emoji: Emoji
    public var color: PaletteColor
}

enum PaletteColor: String, CaseIterable {
    case red, orange, yellow, green, blue, purple, pink, gray

    var swiftUIColor: Color {
        switch self {
        case .red: .red
        case .orange: .orange
        case .yellow: .yellow
        case .green: .green
        case .blue: .blue
        case .purple: .purple
        case .pink: .pink
        case .gray: .gray
        }
    }
}

