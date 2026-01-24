//
//  WatchConnector.swift
//  MindPulse
//
//  Created by Petra  Šátková on 20.01.2026.
//

import Foundation
import WatchConnectivity

@available(iOS 26.0, *)
class WatchConnector : NSObject, WCSessionDelegate, WatchConnecting {
    
    private var session: WCSession
    private var dataManager: DataManaging
    
    init(session: WCSession = .default) {
        self.session = session
        self.dataManager = DIContainer.shared.resolve()
        super.init()
        self.session.delegate = self
        self.session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        session.activate()
    }
    
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any]) {
        guard let data = userInfo["payload"] as? Data else { return }

        // all samples from finished activity - let data manager handle saving to core data
        if let batch = try? JSONDecoder().decode(HeartRateBatchDTO.self, from: data) {
            dataManager.addHeartRateSamples(samples: batch)
        }
    }
    
    // Sends the activity data to the watch app
    func sendActivity(activity: ActivityModel) {
        if session.isReachable {
            var message: [String: Any] = [
                "action": "add",
                "id": activity.id.uuidString,
                "name": activity.name,
                "emoji": activity.emoji,
                "color": activity.color.rawValue,
                "hrRecording": activity.hrRecording
            ]
            
            session.sendMessage(message, replyHandler: nil) { error in
                print("Sending error: \(error.localizedDescription)")
            }
            
        } else {
            print("Session is not reachable")
        }
    }
    
    // Sends a delete command for the activity to the watch app
    func deleteActivity(activityId: UUID) {
        if session.isReachable {
            let message: [String: Any] = [
                "action": "delete",
                "id": activityId.uuidString
            ]
            
            session.sendMessage(message, replyHandler: nil) { error in
                print("Sending error: \(error.localizedDescription)")
            }
        } else {
            print("Session is not reachable")
        }
    }
}
