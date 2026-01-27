//
//  WatchViewModel.swift
//  MindPulse
//
//  Created by Petra  Šátková on 22.01.2026.
//

import Foundation

@Observable
class WatchViewModel {
    
    var state: WatchState = WatchState()
    var currentBPM: Int = 0
    
    private var dataManager: DataManaging
    private var heartRateManager: HeartRateManaging
    private var phoneConnector: PhoneConnecting
    private var hrSamples: [HeartRateSampleModel] = []
    
    init() {
        self.dataManager = DIContainer.shared.resolve()
        self.heartRateManager = DIContainer.shared.resolveFactory()
        self.phoneConnector = DIContainer.shared.resolve()
        
        self.phoneConnector.requestInitialSync()
        
        heartRateManager.onSample = { [weak self] bpm, timestamp in
            self?.currentBPM = Int(bpm)
            self?.hrSamples.append(
                HeartRateSampleModel(
                    id: UUID(),
                    bpm: bpm,
                    timestamp: timestamp
                )
            )
        }
        
        // Reloads activities when notified of updates
        NotificationCenter.default.addObserver(forName: Notification.Name("ActivitiesUpdated"), object: nil, queue: .main) { [weak self] _ in
            self?.fetchActivities()
        }
    }
    
    func fetchActivities() {
        state.activities = dataManager.fetchAllActivities()
    }
    
    func startActivity() {
        do {
            try heartRateManager.startRecording()
        } catch {
            print("Error starting heart rate recording: \(error.localizedDescription)")
        }
    }

    func requestAuthorization() async {
        try? await heartRateManager.requestAuthorization()
    }
    
    // v momente ako user hitne stop alebo sa dokonci aktivita na hodinkach, zavola sa tato funkcia a vsetky samples sa poslu do mobilu pomocou tranfer user info
    func stopActivity(activityId: UUID) {
        heartRateManager.stopRecording()

        let payload = HeartRateBatchDTO(
            activityId: activityId,
            samples: hrSamples
        )

        phoneConnector.transferBatchOfSamples(payload: payload)
        hrSamples.removeAll()
    }
}
