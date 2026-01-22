//
//  PhoneConnector.swift
//  MindPulse Watch Watch App
//
//  Created by Petra  Šátková on 21.01.2026.
//
//

import SwiftUI
import WatchConnectivity
import CoreData

class PhoneConnector: NSObject, WCSessionDelegate, PhoneConnecting {
    
    private var session: WCSession
    private var dataManager: DataManaging
    private var heartRateManager: HeartRateManaging
    
    init(session: WCSession = .default, dataManager: DataManaging, heartRateManager: HeartRateManaging) {
        self.session = session
        self.dataManager = dataManager
        self.heartRateManager = heartRateManager
        super.init()
        self.session.delegate = self
        self.session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        let activity = ActivityModel(
            id: message["id"] as? UUID ?? UUID(),
            name: message["name"] as? String ?? "No name",
            emoji: message["emoji"] as? String ?? "👀",
            color: PaletteColor(rawValue: message["color"] as? String ?? "blue") ?? .blue,
            hrRecording: message["hrRecording"] as? Bool ?? true
        )
        
        dataManager.addActivity(newActivity: activity)
    }
    
    func transferBatchOfSamples(payload: HeartRateBatchDTO) {
        // TODO ako sa to posiela?
    }
}
