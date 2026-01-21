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
    
    init(session: WCSession = .default, dataManager: DataManaging) {
        self.session = session
        self.dataManager = dataManager
        super.init()
        self.session.delegate = self
        self.session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
        
    }
    
    // transferUserInfo
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
//        let place = CoffeePlace(
//            id: message["id"] as? UUID ?? UUID(),
//            name : message["name"] as? String ?? "Unknown",
//            placeType: PlaceType(rawValue: message["placeType"] as? Int16 ?? 0) ?? .Coffee,
//            rating: message["rating"] as? Double ?? 0.0,
//            coordinates: .init(
//                latitude: message["lat"] as? Double ?? 0.0,
//                longitude: message["lon"] as? Double ?? 0.0)
//        )
//        
//        addNewPlace(place: place)
//        
//        DispatchQueue.main.async {
//            
//        }
    }
    
    func addNewPlace(){
//        let cp = PlaceEntity(context: dataManager.context)
//        
//        cp.id = place.id
//        cp.name = place.name
//        cp.type = place.placeType.rawValue
//        cp.rating = place.rating
//        cp.lat = place.coordinates.latitude
//        cp.lon = place.coordinates.longitude
//        
//        dataManager.savePlace(place: cp)
    }
}
