//
//  ActivityModel.swift
//  MindPulse
//
//  Created by Petra  Šátková on 20.01.2026.
//

import SwiftUI
//import ElegantEmojiPicker

struct ActivityModel: Identifiable {
    public var id: UUID
    public var name: String
    public var emoji: String
    public var color: PaletteColor
    public var hrRecording: Bool
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

//SampleData for Watch design testing
extension ActivityModel {
    static let sampleData: [ActivityModel] = [
        ActivityModel(
            id: UUID(),
            name: "Meditation",
            emoji: "🧘‍♀️",
            color: .orange,
            hrRecording: false
        ),
        ActivityModel(
            id: UUID(),
            name: "Running",
            emoji: "🏃‍♂️",
            color: .blue,
            hrRecording: false
        ),
        ActivityModel(
            id: UUID(),
            name: "Deep Performance Work",
            emoji: "💻",
            color: .purple,
            hrRecording: false
        ),
        ActivityModel(
            id: UUID(),
            name: "Reading",
            emoji: "📚",
            color: .green,
            hrRecording: false
        ),
        ActivityModel(
            id: UUID(),
            name: "Sleep",
            emoji: "😴",
            color: .gray,
            hrRecording: false
        )
    ]
}
