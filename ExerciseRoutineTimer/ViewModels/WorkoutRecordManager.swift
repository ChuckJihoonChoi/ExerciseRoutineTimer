//
//  WorkoutRecordManager.swift
//  ExerciseRoutineTimer
//
//  Created by JH's macbook on 5/6/25.
//
import Foundation
import SwiftData

class WorkoutRecordManager: ObservableObject {
    private let modelContext: ModelContext
    private(set) var currentRoutineHistory: RoutineHistory?

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func createRoutineHistory(for routine: Routine) -> RoutineHistory {
        let history = RoutineHistory(
            routineId: routine.id,
            routineName: routine.name,
            totalSeconds: 0,
            createdAt: Date()
        )
        modelContext.insert(history)
        currentRoutineHistory = history
        return history
    }
    
    func findOrCreateModuleHistory(for module: Module) -> ModuleHistory? {
        guard let routineHistory = currentRoutineHistory else { return nil }
        let histories: [ModuleHistory] = (try? modelContext.fetch(FetchDescriptor<ModuleHistory>())) ?? []
        if let existing = histories.first(where: { $0.moduleName == module.name && $0.routineHistory.id == routineHistory.id }) {
            return existing
        }

        let newHistory = ModuleHistory(
            orderIndex: module.orderIndex,
            moduleName: module.name,
            executedSets: 0,
            executedReps: 0,
            executedWeight: 0,
            executedWorkSeconds: 0,
            executedRestSeconds: 0,
            routineHistory: routineHistory
        )
        modelContext.insert(newHistory)
        return newHistory
    }
    
    // Save only workout records when a set start
    func addWorkSet(to module: Module, setIndex: Int, workSeconds: Int) {
        guard let mh = findOrCreateModuleHistory(for: module) else { return }
        
        if mh.setRecords.contains(where: { $0.setIndex == setIndex }) {
            print("⚠️ Duplicate setIndex \(setIndex) detected — skipping insert.")
            return
        }
        
        let setRecord = WorkoutSetRecord(
            setIndex: setIndex,
            executedReps: module.repititions,
            executedWeight: module.weight,
            executedWorkSeconds: workSeconds,
            executedRestSeconds: 0,
            moduleHistory: mh
        )
        // Add directly to the relation array
        mh.setRecords.append(setRecord)
        modelContext.insert(setRecord)
        
        mh.executedWeight = module.weight
        mh.executedReps = module.repititions
        // cumulative value reflection
        mh.executedSets += 1
        mh.executedWorkSeconds += workSeconds
    }

    // Update only rest seconds for the set
    func updateRestSeconds(for module: Module, setIndex: Int, restSeconds: Int) {
        guard let mh = findOrCreateModuleHistory(for: module) else { return }
        if let record = mh.setRecords.first(where: { $0.setIndex == setIndex }) {
            
            record.executedRestSeconds = restSeconds
            mh.executedRestSeconds += restSeconds
        }   else {
            print("❌ setRecord not found for index \(setIndex)")
        }
    }
    
    func updateTotalSeconds(_ seconds: Int) {
        guard let routineHistory = currentRoutineHistory else { return }
        routineHistory.totalSeconds = seconds
    }

    func reset() {
        currentRoutineHistory = nil
    }
}
