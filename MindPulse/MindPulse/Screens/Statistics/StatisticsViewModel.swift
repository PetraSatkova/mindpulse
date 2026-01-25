//
//  StatisticsViewModel.swift
//  MindPulse
//
//  Created by Petra  Šátková on 24.01.2026.
//

import Foundation

@Observable
class StatisticsViewModel {
    var state: StatisticsState = StatisticsState()
    
    private var dataManager: DataManaging
    
    init() {
        dataManager = DIContainer.shared.resolve()
    }
}

extension StatisticsViewModel {
    
    func fetchActivities() {
        let activities: [ActivityModel] = dataManager.fetchAllActivities()
        state.activities = activities
    }
    
    func fetchRcords() {
        let records: [RecordModel] = dataManager.fetchAllRecords()
        state.records = records
    }
    
    func calculateTime(activity: ActivityModel?) {
        var totalSeconds: Int = 0
        let recordsToCalculate: [RecordModel] = activity == nil ?
                state.records : // all records for all activities
                dataManager.fetchRecordsByActivityId(activityId: activity?.id ?? UUID()) // records of filtered activity
 
        for record in recordsToCalculate {
            totalSeconds += Int(record.durationSeconds)
        }
        
        state.totalSeconds = totalSeconds
    }
    
    // call when activity from filter is chosen
    func calculateTotalCount(activity: ActivityModel?) {
        
    }
}
