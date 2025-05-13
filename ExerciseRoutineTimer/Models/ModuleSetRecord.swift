//
//  ModuleSetRecord.swift
//  ExerciseRoutineTimer
//
//  Created by JH's macbook on 5/6/25.
//
import Foundation
import SwiftData

@Model
class WorkoutSetRecord {
    var id: UUID
    var setIndex: Int
    var executedReps: Int
    var executedWeight: Int
    var executedWorkSeconds: Int
    var executedRestSeconds: Int

    @Relationship var moduleHistory: ModuleHistory

    init(id: UUID = UUID(),
         setIndex: Int,
         executedReps: Int,
         executedWeight: Int,
         executedWorkSeconds: Int,
         executedRestSeconds: Int,
         moduleHistory: ModuleHistory) {
        self.id = id
        self.setIndex = setIndex
        self.executedReps = executedReps
        self.executedWeight = executedWeight
        self.executedWorkSeconds = executedWorkSeconds
        self.executedRestSeconds = executedRestSeconds
        self.moduleHistory = moduleHistory
    }
}
