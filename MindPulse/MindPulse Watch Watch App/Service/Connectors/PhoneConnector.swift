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
    
    // Handles incoming messages to add or delete activities
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        guard let action = message["action"] as? String else { return }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            if action == "add" {
                let activity = ActivityModel(
                    id: UUID(uuidString: message["id"] as? String ?? "") ?? UUID(),
                    name: message["name"] as? String ?? "No name",
                    emoji: message["emoji"] as? String ?? "👀",
                    color: PaletteColor(rawValue: message["color"] as? String ?? "blue") ?? .blue,
                    hrRecording: message["hrRecording"] as? Bool ?? true
                )
                self.dataManager.addActivity(newActivity: activity)
            } else if action == "delete" {
                if let idString = message["id"] as? String, let id = UUID(uuidString: idString) {
                    _ = self.dataManager.deleteActivity(activityId: id)
                }
            }
            
            NotificationCenter.default.post(name: Notification.Name("ActivitiesUpdated"), object: nil)
        }
    }
    
    func transferBatchOfSamples(payload: HeartRateBatchDTO) {
        // TODO ako sa to posiela?
    }
}
