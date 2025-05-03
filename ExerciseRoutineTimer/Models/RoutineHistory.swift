//
//  RoutineHistory.swift
//  FlexPlanDraft
//
//  Created by JH's macbook on 5/2/25.
//
import Foundation
import SwiftData

@Model
class RoutineHistory {
    var id: UUID
    var routineId: UUID
    var routineName: String
    var totalSeconds: Int
    var createdAt: Date

    init(id: UUID = UUID(), routineId: UUID, routineName: String,
         totalSeconds: Int, createdAt: Date = .now) {
        self.id = id
        self.routineId = routineId
        self.routineName = routineName
        self.totalSeconds = totalSeconds
        self.createdAt = createdAt
    }
}


