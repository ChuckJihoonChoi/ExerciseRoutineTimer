//
//  ModuleHistory.swift
//  FlexPlanDraft
//
//  Created by JH's macbook on 5/2/25.
//
import Foundation
import SwiftData

@Model
class ModuleHistory {
    var id: UUID
    var routineHistoryId: UUID
    var moduleName: String
    var executedSets: Int
    var executedWeight: Int
    var executedWorkSeconds: Int
    var executedRestSeconds: Int
    var note: String

    init(id: UUID = UUID(), routineHistoryId: UUID, moduleName: String,
         executedSets: Int, executedWeight: Int, executedWorkSeconds: Int,
         executedRestSeconds: Int, note: String = "") {
        self.id = id
        self.routineHistoryId = routineHistoryId
        self.moduleName = moduleName
        self.executedSets = executedSets
        self.executedWeight = executedWeight
        self.executedWorkSeconds = executedWorkSeconds
        self.executedRestSeconds = executedRestSeconds
        self.note = note
    }
}


