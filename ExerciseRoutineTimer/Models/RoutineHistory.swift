//
//  RoutineHistory.swift
//  FlexPlanDraft
//
//  Created by JH's macbook on 5/2/25.
//
import Foundation
import SwiftData

@Model
class RoutineHistory: Identifiable {
    var id: UUID = UUID()
    var routineId: UUID  // Original Routine Id
    var routineName: String
    var totalSeconds: Int
    var createdAt: Date

    // Connected Module Records
    @Relationship(deleteRule: .cascade, inverse: \ModuleHistory.routineHistory)
    var modules: [ModuleHistory]

    init(id: UUID = UUID(), routineId: UUID, routineName: String,
         totalSeconds: Int, createdAt: Date = .now) {
        self.id = id
        self.routineId = routineId
        self.routineName = routineName
        self.totalSeconds = totalSeconds
        self.createdAt = createdAt
        self.modules = []
    }
}
extension RoutineHistory {
    var formattedDuration: String {
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60

        if hours > 0 {
            return String(format: "%dh %02dm", hours, minutes)
        } else if minutes > 0 {
            return String(format: "%02dm %02ds", minutes, seconds)
        } else {
            return String(format: "%02ds", seconds)
        }
    }
}



