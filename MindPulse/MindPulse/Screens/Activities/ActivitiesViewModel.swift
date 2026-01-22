//
//  ActivitiesViewModel.swift
//  MindPulse
//
//  Created by Petra  Šátková on 21.01.2026.
//

import Foundation

@available(iOS 26.0, *)
@Observable
class ActivitiesViewModel {
    var state: ActivitiesState = ActivitiesState()
    
    private var dataManager: DataManaging
    
    init() {
        dataManager = DIContainer.shared.resolve()
    }
}

@available(iOS 26.0, *)
extension ActivitiesViewModel {
    
    func fetchActivities() {
        let activities: [ActivityModel] = dataManager.fetchAllActivities()
        state.activities = activities
    }
    
    func addActivity(newActivity: ActivityModel) {
        dataManager.addActivity(newActivity: newActivity)
    }
    
    func deleteActivity(activityId: UUID) {
        let isDeleted = dataManager.deleteActivity(activityId: activityId)
        self.fetchActivities()
    }
}
