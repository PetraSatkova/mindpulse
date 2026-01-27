//
//  StatsChart.swift
//  MindPulse
//
//  Created by Petra  Šátková on 27.01.2026.
//

import SwiftUI
import Charts

struct SalesPoint: Identifiable {
    let id = UUID()
    let day: String
    let value: Double
}

struct LineChart: View {
    let data: [SalesPoint] = [
        .init(day: "Mon", value: 12),
        .init(day: "Tue", value: 18),
        .init(day: "Wed", value: 9),
        .init(day: "Thu", value: 22),
        .init(day: "Fri", value: 16),
    ]

    var body: some View {
        Chart(data) { point in
            LineMark(
                x: .value("Day", point.day),
                y: .value("Value", point.value)
            )
            PointMark(
                x: .value("Day", point.day),
                y: .value("Value", point.value)
            )
        }
        .frame(height: 220)
        .padding()
    }
}

