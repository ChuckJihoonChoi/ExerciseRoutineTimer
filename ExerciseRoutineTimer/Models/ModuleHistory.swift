//
//  ModuleHistory.swift
//  ExerciseRoutineTimer
//
//  Created by JH's macbook on 5/2/25.
//
import Foundation
import SwiftData

@Model
class ModuleHistory {
    var id: UUID
    var orderIndex: Int
    var moduleName: String
    var executedSets: Int
    var executedReps: Int
    var executedWeight: Int
    var executedWorkSeconds: Int
    var executedRestSeconds: Int
    var note: String

    @Relationship var routineHistory: RoutineHistory
    @Relationship var setRecords: [WorkoutSetRecord] = [] // Set Record

    init(id: UUID = UUID(), orderIndex:Int, moduleName: String,
         executedSets: Int, executedReps: Int, executedWeight: Int,
         executedWorkSeconds: Int, executedRestSeconds: Int,
         note: String = "", routineHistory: RoutineHistory) {
        self.id = id
        self.orderIndex = orderIndex
        self.moduleName = moduleName
        self.executedSets = executedSets
        self.executedReps = executedReps
        self.executedWeight = executedWeight
        self.executedWorkSeconds = executedWorkSeconds
        self.executedRestSeconds = executedRestSeconds
        self.note = note
        self.routineHistory = routineHistory
    }
}

