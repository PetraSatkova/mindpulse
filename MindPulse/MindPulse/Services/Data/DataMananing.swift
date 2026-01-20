//
//  DataMananing.swift
//  MindPulse
//
//  Created by Petra  Šátková on 20.01.2026.
//

import SwiftUI
import CoreData

protocol DataMananing {
    var context: NSManagedObjectContext { get }
    
    func addActivity(newActivity: ActivityModel)
    func fetchAllActivities() -> [ActivityModel]
    func deleteActivity(activityId: UUID) -> Bool
    
    func addRecord(activityId: UUID, record: RecordModel)
    func fetchRecordsByActivityId(activityId: UUID) -> [RecordModel]
}
