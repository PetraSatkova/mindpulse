//
//  DataManager.swift
//  MindPulse
//
//  Created by Petra  Šátková on 20.01.2026.
//

import SwiftUI
import CoreData

class DataManager: DataMananing {
    
    private let container = NSPersistentContainer(name: "Activities")
    
    var context: NSManagedObjectContext {
        container.viewContext
    }
    
    init() {
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Cannot create persistent store: \(error.localizedDescription)")
            }
        }
    }
    
    
    func addActivity(newActivity: ActivityModel) {
        let activityEntity = ActivityEntity(context: context)
        activityEntity.id = newActivity.id
        activityEntity.name = newActivity.name
        activityEntity.emoji = newActivity.emoji
        activityEntity.colorKey = newActivity.color.rawValue
        
        save()
    }
    
    func fetchAllActivities() -> [ActivityModel] {
        let request = NSFetchRequest<ActivityEntity>(entityName: "ActivityEntity")
        var activities: [ActivityEntity] = []
        
        do {
            activities = try context.fetch(request)
        }catch{
            print("Cannot fetch data: \(error.localizedDescription)")
        }
        return activities.map { entity in
            ActivityModel(
                id: entity.id ?? UUID(),
                name: entity.name ?? "no name",
                emoji: entity.emoji ?? "👀",
                color: PaletteColor(rawValue: entity.colorKey ?? "blue") ?? PaletteColor.blue
            )
        }
    }
    
    func deleteActivity(activityId: UUID) -> Bool {
        // fetch activity
        let activityRequest = NSFetchRequest<ActivityEntity>(entityName: "ActivityEntity")
        activityRequest.predicate = NSPredicate(format: "id == %@", activityId as CVarArg)
        
        var activities: [ActivityEntity] = []
        
        do {
            activities = try context.fetch(activityRequest)
        } catch {
            print("Cannot fetch data: \(error.localizedDescription)")
        }
        
        guard let activityToDelete = activities.first else { return false }
        
        // fetch and delete activitie's records
        let recordRequest = NSFetchRequest<RecordEntity>(entityName: "RecordEntity")
        recordRequest.predicate = NSPredicate(format: "activity.id == %@", activityId as CVarArg)
        
        var records: [RecordEntity] = []
        
        do {
            records = try context.fetch(recordRequest)
        } catch {
            print("Cannot fetch data: \(error.localizedDescription)")
        }
        
        guard records != [] else { return true }
        
        records.forEach { record in
            context.delete(record)
        }
        
        save()
        return true
    }
    
    func addRecord(activityId: UUID, record: RecordModel) {
        let request = NSFetchRequest<ActivityEntity>(entityName: "ActivityEntity")
        request.predicate = NSPredicate(format: "id == %@", activityId as CVarArg)
        
        var activities: [ActivityEntity] = []
        
        do {
            activities = try context.fetch(request)
        } catch{
            print("Cannot fetch data: \(error.localizedDescription)")
        }
        
        guard let activity = activities.first else { return }
        
        let newRecord = RecordEntity(context: context)
        newRecord.id = UUID()
        newRecord.date = record.date
        newRecord.durationSeconds = Int16(record.durationSeconds)
        newRecord.activity = activity
        save()
    }
    
    func fetchRecordsByActivityId(activityId: UUID) -> [RecordModel] {
        let recordRequest = NSFetchRequest<RecordEntity>(entityName: "RecordEntity")
        recordRequest.predicate = NSPredicate(format: "activity.id == %@", activityId as CVarArg)
        
        var records: [RecordEntity] = []
        
        do {
            records = try context.fetch(recordRequest)
        } catch {
            print("Cannot fetch data: \(error.localizedDescription)")
        }
        
        return records.map { record in
            RecordModel(
                id: record.id ?? UUID(),
                date: record.date ?? Date(),
                durationSeconds: record.durationSeconds)
        }
    }
    
    
}

private extension DataManager {
    private func save(){
        if context.hasChanges {
         do {
             try context.save()
            }catch {
                print("Cannot save MOC: \(error.localizedDescription)")
         }
        }
    }
}
