//
//  Routine.swift
//  FlexPlanDraft
//
//  Created by JH's macbook on 5/2/25.
//
import Foundation
import SwiftData

@Model
class Routine {
    var id: UUID
    var name: String
    var moduleIds: [UUID]
    var restBetweenModules: Int
    var voiceEnabled: Bool
    var vibrationEnabled: Bool
    var createdAt: Date
    var lastExecutedAt: Date?

    init(id: UUID = UUID(), name: String, moduleIds: [UUID] = [],
         restBetweenModules: Int = 0, voiceEnabled: Bool = false, vibrationEnabled: Bool = false,
         createdAt: Date = .now, lastExecutedAt: Date? = nil) {
        self.id = id
        self.name = name
        self.moduleIds = moduleIds
        self.restBetweenModules = restBetweenModules
        self.voiceEnabled = voiceEnabled
        self.vibrationEnabled = vibrationEnabled
        self.createdAt = createdAt
        self.lastExecutedAt = lastExecutedAt
    }
}


