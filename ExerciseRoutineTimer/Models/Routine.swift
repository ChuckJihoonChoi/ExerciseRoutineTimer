//
//  Routine.swift
//  ExerciseRoutineTimer
//
//  Created by JH's macbook on 5/2/25.
//
import Foundation
import SwiftData

@Model
class Routine {
    var id: UUID
    var name: String
    var restBetweenModules: Int
    var voiceEnabled: Bool
    var vibrationEnabled: Bool
    var createdAt: Date
    var lastExecutedAt: Date?

    // Relation between currernt routine and model
    @Relationship(deleteRule: .cascade, inverse: \Module.routine)
    var modules: [Module]
    
    init(id: UUID = UUID(), name: String, restBetweenModules: Int = 0, voiceEnabled: Bool = false, vibrationEnabled: Bool = false,
         createdAt: Date = .now, lastExecutedAt: Date? = nil) {
        self.id = id
        self.name = name
        self.restBetweenModules = restBetweenModules
        self.voiceEnabled = voiceEnabled
        self.vibrationEnabled = vibrationEnabled
        self.createdAt = createdAt
        self.lastExecutedAt = lastExecutedAt
        self.modules = []
    }
}

