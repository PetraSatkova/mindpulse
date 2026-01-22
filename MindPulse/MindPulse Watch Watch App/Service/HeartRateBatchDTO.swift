//
//  HeartRateBatchDTO.swift
//  MindPulse
//
//  Created by Petra  Šátková on 22.01.2026.
//

import Foundation

struct HeartRateBatchDTO: Codable {
    let activityId: UUID
    let samples: [HeartRateSampleModel]
}
